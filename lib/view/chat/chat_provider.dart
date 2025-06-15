import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../api/api.dart';
import '../../model/character.dart' hide ChatMessage;
import '../../model/chat_message.dart';
import '../../model/common.dart';
import '../../util/log.dart';

/// 聊天状态数据类
class ChatState {
  final Character? character;
  final List<ChatMessage> messageList;
  final bool isLoading;
  final bool isGeneratingMessage;
  final bool isGeneratingImage;
  final bool isGeneratingIdea;
  final bool isEditMode;
  final bool isRemoveMode;
  final bool isSaveMode;
  final bool isPhotoWallVisible;
  final List<String> photoUrls;
  final List<ChatMessage> regenerateMessageList;
  final int regenerateMessageIndex;
  final ChatMessage? needEditMessage;
  final ChatMessage? currentPlayingVoiceMessage;
  final List<ChatMessage> removeMessageList;
  final List<ChatMessage> saveMessageList;
  final List<ChatMessage> generatedIdeas;
  final int? selectedIdeaIndex;
  final int page;
  final int? currentSessionId; // 新增字段，用于存储当前会话ID

  const ChatState({
    this.character,
    this.messageList = const [],
    this.isLoading = false,
    this.isGeneratingMessage = false,
    this.isGeneratingImage = false,
    this.isGeneratingIdea = false,
    this.isEditMode = false,
    this.isRemoveMode = false,
    this.isSaveMode = false,
    this.isPhotoWallVisible = true,
    this.photoUrls = const [],
    this.regenerateMessageList = const [],
    this.regenerateMessageIndex = 0,
    this.needEditMessage,
    this.currentPlayingVoiceMessage,
    this.removeMessageList = const [],
    this.saveMessageList = const [],
    this.generatedIdeas = const [],
    this.selectedIdeaIndex,
    this.page = 1,
    this.currentSessionId, // 初始化
  });

  ChatState copyWith({
    Character? character,
    List<ChatMessage>? messageList,
    bool? isLoading,
    bool? isGeneratingMessage,
    bool? isGeneratingImage,
    bool? isGeneratingIdea,
    bool? isEditMode,
    bool? isRemoveMode,
    bool? isSaveMode,
    bool? isPhotoWallVisible,
    List<String>? photoUrls,
    List<ChatMessage>? regenerateMessageList,
    int? regenerateMessageIndex,
    ChatMessage? needEditMessage,
    ChatMessage? currentPlayingVoiceMessage,
    List<ChatMessage>? removeMessageList,
    List<ChatMessage>? saveMessageList,
    List<ChatMessage>? generatedIdeas,
    int? selectedIdeaIndex,
    int? page,
    int? currentSessionId, // copyWith 中添加
  }) {
    return ChatState(
      character: character ?? this.character,
      messageList: messageList ?? this.messageList,
      isLoading: isLoading ?? this.isLoading,
      isGeneratingMessage: isGeneratingMessage ?? this.isGeneratingMessage,
      isGeneratingImage: isGeneratingImage ?? this.isGeneratingImage,
      isGeneratingIdea: isGeneratingIdea ?? this.isGeneratingIdea,
      isEditMode: isEditMode ?? this.isEditMode,
      isRemoveMode: isRemoveMode ?? this.isRemoveMode,
      isSaveMode: isSaveMode ?? this.isSaveMode,
      isPhotoWallVisible: isPhotoWallVisible ?? this.isPhotoWallVisible,
      photoUrls: photoUrls ?? this.photoUrls,
      regenerateMessageList:
          regenerateMessageList ?? this.regenerateMessageList,
      regenerateMessageIndex:
          regenerateMessageIndex ?? this.regenerateMessageIndex,
      needEditMessage: needEditMessage ?? this.needEditMessage,
      currentPlayingVoiceMessage:
          currentPlayingVoiceMessage ?? this.currentPlayingVoiceMessage,
      removeMessageList: removeMessageList ?? this.removeMessageList,
      saveMessageList: saveMessageList ?? this.saveMessageList,
      generatedIdeas: generatedIdeas ?? this.generatedIdeas,
      selectedIdeaIndex: selectedIdeaIndex ?? this.selectedIdeaIndex,
      page: page ?? this.page,
      currentSessionId: currentSessionId ?? this.currentSessionId, // 更新
    );
  }
}

/// 聊天状态管理器
class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState());

  // 控制器
  final scrollController = ScrollController();
  final refreshController = RefreshController();
  final focusNode = FocusNode();
  final textEditingController = TextEditingController();

  // 流订阅
  StreamSubscription? streamSubscription;
  StreamSubscription? streamSubscriptionIdea;

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    streamSubscription?.cancel();
    streamSubscriptionIdea?.cancel();
    super.dispose();
  }

  /// 设置角色
  void setCharacter(Character character) {
    // When setting a new character, fully reset the relevant chat state.
    // _loadMessages will be called by _initializeChat.
    // If currentSessionId is null, continueChat API is expected to
    // fetch the latest/new session for the character.
    state = ChatState(
      character: character,
      currentSessionId: null, // Explicitly set to null
      messageList: [],
      page: 1,
      isLoading: false,
      isGeneratingMessage: false,
      isGeneratingImage: false,
      isGeneratingIdea: false,
      isEditMode: false,
      isRemoveMode: false,
      isSaveMode: false,
      isPhotoWallVisible: state.isPhotoWallVisible, // Preserve user preference
      photoUrls: const [], // Reset photos for the new character
      regenerateMessageList: const [],
      regenerateMessageIndex: 0,
      needEditMessage: null,
      currentPlayingVoiceMessage: null,
      removeMessageList: const [],
      saveMessageList: const [],
      generatedIdeas: const [],
      selectedIdeaIndex: null,
    );
    _initializeChat();
  }

  /// 初始化聊天
  void _initializeChat() {
    _loadMessages();
    _loadPhotoUrls();
  }

  /// 加载消息列表
  Future<void> _loadMessages() async {
    if (state.character == null) {
      debugPrint('_loadMessages: Character is null, returning.');
      return;
    }

    // If state.currentSessionId is null here, it means we're likely trying to load
    // the initial/latest session for the character. The continueChat API
    // is expected to handle sessionId: null by returning the appropriate session
    // (e.g., latest, or a new one) and its ID.
    debugPrint(
        '_loadMessages: Attempting to load messages for character ${state.character!.characterId} with session ID: ${state.currentSessionId}');
    state = state.copyWith(
        isLoading: true,
        messageList: [],
        page: 1); // Clear old messages, reset page

    try {
      final response = await ApiService.instance.character.continueChat(
        characterId: state.character!.characterId,
        sessionId: state.currentSessionId, // This can be null
      );

      debugPrint(
          '_loadMessages: API Response - Code: ${response.code}, Result: ${response.result?.toString()}');

      if (response.code == 0 && response.result != null) {
        final messages = response.result!.messages ?? [];
        debugPrint(
            '_loadMessages: Success. Session ID from API: ${response.result!.id}. Messages count: ${messages.length}');

        // 添加详细的消息调试信息
        for (int i = 0; i < messages.length; i++) {
          final msg = messages[i];
          debugPrint(
              '_loadMessages: Message $i - Type: ${msg.type}, Content: ${msg.content.substring(0, msg.content.length > 50 ? 50 : msg.content.length)}..., ID: ${msg.id}');
        }

        state = state.copyWith(
          messageList: messages,
          currentSessionId:
              response.result!.id, // API MUST return the session ID
          isLoading: false,
        );
      } else {
        debugPrint(
            '_loadMessages: API error or no messages. Code: ${response.code}, Msg: ${response.msg}');
        state = state.copyWith(
          messageList: [], // Clear messages on failure
          isLoading: false,
          // currentSessionId will remain as it was (null or previous value if API failed to return new one)
        );
      }
    } catch (e) {
      debugPrint('_loadMessages: Exception: $e');
      state = state.copyWith(
        messageList: [], // Clear messages on exception
        isLoading: false,
      );
    }
  }

  /// 加载照片墙
  Future<void> _loadPhotoUrls() async {
    try {
      // TODO: 实现从API加载照片墙的逻辑
      // final urls = await chatApi.getPhotoUrls(character.id);
      // state = state.copyWith(photoUrls: urls);

      // 临时使用空列表
      state = state.copyWith(photoUrls: []);
    } catch (e) {
      debugPrint('加载照片墙失败: $e');
    }
  }

  /// 发送消息
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    if (state.currentSessionId == null) {
      debugPrint('错误：无法发送消息，会话ID为空。');
      await startNewConversation(showMessageAfterCreation: false);
      if (state.currentSessionId == null) {
        return;
      }
    }

    final userMessage = ChatMessage(
      sessionId: state.currentSessionId!,
      content: content,
      type: 'user',
      createdAt: DateTime.now().toIso8601String(),
    );

    // 添加用户消息到列表的最前面
    state = state.copyWith(messageList: [userMessage, ...state.messageList]);

    // 清空输入框
    textEditingController.clear();

    // 开始生成AI回复
    state = state.copyWith(isGeneratingMessage: true);

    // 创建一个初始的AI消息对象，稍后会更新其内容
    final initialAIMessage = ChatMessage(
      sessionId: state.currentSessionId!,
      content: '', // 初始内容为空
      type: 'assistant',
      createdAt: DateTime.now().toIso8601String(),
    );

    // 将初始的空AI消息添加到列表的最前面
    state =
        state.copyWith(messageList: [initialAIMessage, ...state.messageList]);

    try {
      final stream = ApiService.instance.character.sendChatMessage(
        sessionId: state.currentSessionId!,
        message: content,
      );

      String currentAIContent = ''; // 用于存储来自流的累积内容

      await for (final chunkData in stream) {
        Log.instance.logger.d('Received chunk: $chunkData');

        if (chunkData is Map<String, dynamic> && chunkData['code'] == 0) {
          final result = chunkData['result'] as Map<String, dynamic>?;
          if (result != null) {
            final newContentPiece = result['content'] as String?;
            final bool isDone = (result['done'] as bool?) ?? false;

            if (newContentPiece != null) {
              currentAIContent = newContentPiece; // SSE 'content' 被认为是累积的
            }

            final currentMessages = List<ChatMessage>.from(state.messageList);
            // AI消息现在应该在列表的开头
            if (currentMessages.isNotEmpty &&
                currentMessages.first.type == 'assistant') {
              ChatMessage firstAiMsg = currentMessages.first;
              int? finalMessageId = firstAiMsg.id; // 默认保留现有ID

              if (isDone) {
                final sseMessageId = result['uniqId'] as int?;
                if (sseMessageId != null) {
                  finalMessageId = sseMessageId;
                  Log.instance.logger
                      .d('AI Message final ID set to: $finalMessageId');
                }
              }

              currentMessages[0] = ChatMessage(
                // 更新列表的第一个元素
                id: finalMessageId, // 如果完成，则更新为最终ID
                sessionId: firstAiMsg.sessionId,
                content: currentAIContent,
                type: 'assistant',
                createdAt: firstAiMsg.createdAt, // 保留原始创建时间
              );
              state = state.copyWith(messageList: currentMessages);
            }

            if (isDone) {
              // 当 done 为 true 时，消息生成完成。
              // finally 块将处理 isGeneratingMessage = false。
              // 如果流在 done:true 后没有自动关闭，可能需要在此处 break。
            }
          }
        } else if (chunkData is Map<String, dynamic> &&
            chunkData['code'] != 0) {
          final errorMessage = chunkData['msg'] as String? ?? 'Stream error';
          Log.instance.logger.e(
              'SSE Error Chunk: Code ${chunkData['code']}, Msg: $errorMessage');
          final currentMessages = List<ChatMessage>.from(state.messageList);
          // AI消息现在应该在列表的开头
          if (currentMessages.isNotEmpty &&
              currentMessages.first.type == 'assistant') {
            currentMessages[0] = ChatMessage(
              // 更新列表的第一个元素
              id: currentMessages.first.id,
              sessionId: currentMessages.first.sessionId,
              content: "Error: $errorMessage",
              type: 'assistant',
              createdAt: currentMessages.first.createdAt,
            );
            state = state.copyWith(messageList: currentMessages);
          }
          break; // 出现错误时停止处理
        } else {
          Log.instance.logger.w('Received unexpected chunk format: $chunkData');
        }
      }
    } catch (e) {
      debugPrint('发送消息失败: $e');
      final currentMessages = List<ChatMessage>.from(state.messageList);
      // 仅当AI消息仍为空时显示通用错误（避免覆盖SSE流中的特定错误）
      // AI消息现在应该在列表的开头
      if (currentMessages.isNotEmpty &&
          currentMessages.first.type == 'assistant' &&
          (currentMessages.first.content.isEmpty ||
              currentMessages.first.content == "Error: Stream error")) {
        currentMessages[0] = ChatMessage(
          // 更新列表的第一个元素
          id: currentMessages.first.id,
          sessionId: currentMessages.first.sessionId,
          content: "Error: Failed to get response.",
          type: 'assistant',
          createdAt: currentMessages.first.createdAt,
        );
        state = state.copyWith(messageList: currentMessages);
      }
    } finally {
      state = state.copyWith(isGeneratingMessage: false);
    }
  }

  /// 重新生成消息
  Future<void> regenerateMessage() async {
    if (state.messageList.isEmpty) return;

    state = state.copyWith(isGeneratingMessage: true);

    try {
      // 使用CharacterApiService重新生成消息
      // TODO: 需要实现重新生成的API调用

      // 临时逻辑：替换最后一条AI消息
      final messages = List<ChatMessage>.from(state.messageList);
      if (messages.isNotEmpty && messages.last.type == 'assistant') {
        messages.removeLast();
        final newMessage = ChatMessage(
          sessionId: state.character?.characterId ?? 0,
          content: '重新生成的回复: ${Random().nextInt(1000)}',
          type: 'assistant',
          createdAt: DateTime.now().toIso8601String(),
        );
        messages.add(newMessage);
        state = state.copyWith(messageList: messages);
      }
    } catch (e) {
      debugPrint('重新生成消息失败: $e');
    } finally {
      state = state.copyWith(isGeneratingMessage: false);
    }
  }

  /// 生成图片
  Future<void> generateImage() async {
    state = state.copyWith(isGeneratingImage: true);

    try {
      // 使用BaseApiService生成图片
      final request = GenerateImageRequest(
        userId: 1, // TODO: 从用户服务获取实际用户ID
        sessionId: state.character?.characterId ?? 0,
        type: 'chat',
        isGif: 0, // 生成静态图片
      );

      final response = await ApiService.instance.base.generateImage(request);

      if (response.code == 0 && response.result != null) {
        // 创建包含图片的消息
        final imageMessage = ChatMessage(
          sessionId: state.character?.characterId ?? 0,
          content: '生成了一张图片',
          type: 'assistant',
          createdAt: DateTime.now().toIso8601String(),
        );

        final updatedMessages = [...state.messageList, imageMessage];
        state = state.copyWith(messageList: updatedMessages);
      }
    } catch (e) {
      debugPrint('生成图片失败: $e');
    } finally {
      state = state.copyWith(isGeneratingImage: false);
    }
  }

  /// 生成想法
  Future<void> generateIdeas() async {
    state = state.copyWith(isGeneratingIdea: true);

    try {
      // 使用BaseApiService获取提示示例作为想法
      final response = await ApiService.instance.base.getHintExamples(
        num: 3, // 获取3个想法
      );

      if (response.code == 0 && response.result != null) {
        final ideas = response.result!
            .map((ideaContent) => ChatMessage(
                  sessionId: state.character?.characterId ?? 0,
                  content: ideaContent,
                  type: 'idea',
                  createdAt: DateTime.now().toIso8601String(),
                ))
            .toList();

        state = state.copyWith(generatedIdeas: ideas);
      } else {
        // 如果API失败，使用临时逻辑
        final ideas = List.generate(
            3,
            (index) => ChatMessage(
                  sessionId: state.character?.characterId ?? 0,
                  content: '想法 ${index + 1}: ${Random().nextInt(1000)}',
                  type: 'idea',
                  createdAt: DateTime.now().toIso8601String(),
                ));

        state = state.copyWith(generatedIdeas: ideas);
      }
    } catch (e) {
      debugPrint('生成想法失败: $e');
      // 发生错误时使用默认想法
      final ideas = List.generate(
          3,
          (index) => ChatMessage(
                sessionId: state.character?.characterId ?? 0,
                content: '想法 ${index + 1}: ${Random().nextInt(1000)}',
                type: 'idea',
                createdAt: DateTime.now().toIso8601String(),
              ));

      state = state.copyWith(generatedIdeas: ideas);
    } finally {
      state = state.copyWith(isGeneratingIdea: false);
    }
  }

  /// 下拉刷新
  Future<void> handleRefresh() async {
    try {
      // 重新加载消息
      await _loadMessages();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  /// 上拉加载更多
  Future<void> handleLoadMore() async {
    try {
      // 实现分页加载更多消息的逻辑
      final nextPage = state.page + 1;
      // TODO: 根据实际API添加分页参数来获取更多消息

      state = state.copyWith(page: nextPage);
      refreshController.loadComplete();
    } catch (e) {
      refreshController.loadFailed();
    }
  }

  /// 切换编辑模式
  void toggleEditMode() {
    state = state.copyWith(isEditMode: !state.isEditMode);
  }

  /// 切换删除模式
  void toggleRemoveMode() {
    state = state.copyWith(isRemoveMode: !state.isRemoveMode);
  }

  /// 切换保存模式
  void toggleSaveMode() {
    state = state.copyWith(isSaveMode: !state.isSaveMode);
  }

  /// 切换照片墙可见性
  void togglePhotoWallVisibility() {
    state = state.copyWith(isPhotoWallVisible: !state.isPhotoWallVisible);
  }

  /// 选择想法
  void selectIdea(int index) {
    state = state.copyWith(selectedIdeaIndex: index);
  }

  /// 点击角色信息
  Future<void> onClickCharacterInfo() async {
    // TODO: 导航到角色信息页面
    debugPrint('点击角色信息');
  }

  /// 显示菜单
  Future<void> showMenu() async {
    // TODO: 显示聊天菜单
    debugPrint('显示菜单');
  }

  /// 点击用户头像
  Future<void> onTapUserProfile() async {
    // TODO: 修改用户资料
    debugPrint('点击用户头像');
  }

  /// 添加照片到照片墙
  Future<void> addPhotoToWall() async {
    // TODO: 实现添加照片功能
    debugPrint('添加照片到照片墙');
  }

  /// 播放语音消息
  Future<void> playVoiceMessage(ChatMessage message) async {
    // TODO: 实现语音播放功能
    state = state.copyWith(currentPlayingVoiceMessage: message);
  }

  /// 停止语音播放
  void stopVoiceMessage() {
    state = state.copyWith(currentPlayingVoiceMessage: null);
  }

  /// 编辑消息
  void editMessage(ChatMessage message) {
    state = state.copyWith(needEditMessage: message, isEditMode: true);
  }

  /// 删除消息
  void removeMessage(ChatMessage message) {
    final updatedList = List<ChatMessage>.from(state.removeMessageList);
    if (updatedList.contains(message)) {
      updatedList.remove(message);
    } else {
      updatedList.add(message);
    }
    state = state.copyWith(removeMessageList: updatedList);
  }

  /// 保存消息到记忆
  void saveMessageToMemory(ChatMessage message) {
    final updatedList = List<ChatMessage>.from(state.saveMessageList);
    if (updatedList.contains(message)) {
      updatedList.remove(message);
    } else {
      updatedList.add(message);
    }
    state = state.copyWith(saveMessageList: updatedList);
  }

  /// 取消编辑
  void cancelEdit() {
    state = state.copyWith(isEditMode: false, needEditMessage: null);
  }

  /// 取消删除
  void cancelRemove() {
    state = state.copyWith(isRemoveMode: false, removeMessageList: []);
  }

  /// 取消保存
  void cancelSave() {
    state = state.copyWith(isSaveMode: false, saveMessageList: []);
  }

  /// 开始新对话
  Future<void> startNewConversation(
      {bool showMessageAfterCreation = true}) async {
    try {
      if (state.character != null) {
        // 使用CharacterApiService创建新的聊天会话
        final response = await ApiService.instance.character.createChat(
          characterId: state.character!.characterId,
        );

        if (response.code == 0 && response.result != null) {
          final newSessionId = response.result!.id;
          if (newSessionId == 0) {
            // 新增检查：如果API返回的会话ID为0
            debugPrint('创建新会话失败：API返回的会话ID为0。');
            if (showMessageAfterCreation) {
              // 将 currentSessionId 设置为 null，表示没有有效会话
              state = state
                  .copyWith(messageList: [], page: 1, currentSessionId: null);
              debugPrint(
                  'currentSessionId set to: ${state.currentSessionId}'); // 添加打印
            }
            // 如果 !showMessageAfterCreation (例如在 _loadOrCreateSession 中调用),
            // currentSessionId 保持其调用前的值 (可能为 null), sendMessage 后续会再次尝试创建。
          } else {
            state = state.copyWith(
              currentSessionId: newSessionId, // 更新会话ID
              messageList: [], // 清空消息列表
              page: 1, // 重置页码
            );
            debugPrint(
                'currentSessionId set to: ${state.currentSessionId}'); // 添加打印
            if (showMessageAfterCreation) {
              // 重新加载消息（例如，获取欢迎消息）
              await _loadMessages();
            }
            debugPrint('新的会话已创建，ID: $newSessionId');
          }
        } else {
          debugPrint('创建新会话失败，API返回错误: ${response.msg}');
          if (showMessageAfterCreation) {
            state = state
                .copyWith(messageList: [], page: 1, currentSessionId: null);
            debugPrint(
                'currentSessionId set to: ${state.currentSessionId}'); // 添加打印
          }
        }
      } else {
        // 如果没有角色信息，仅清空本地状态
        if (showMessageAfterCreation) {
          state =
              state.copyWith(messageList: [], page: 1, currentSessionId: null);
          debugPrint(
              'currentSessionId set to: ${state.currentSessionId}'); // 添加打印
        }
      }
    } catch (e) {
      debugPrint('开始新对话失败: $e');
      // 即使API失败，也可以清空本地状态
      if (showMessageAfterCreation) {
        state =
            state.copyWith(messageList: [], page: 1, currentSessionId: null);
        debugPrint(
            'currentSessionId set to: ${state.currentSessionId}'); // 添加打印
      }
    }
  }
}

/// Chat Provider
final chatNotifierProvider =
    StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});
