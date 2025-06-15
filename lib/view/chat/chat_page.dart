import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/character.dart';
import 'chat_provider.dart';
import 'widget/chat_app_bar.dart';
import 'widget/chat_input.dart';
import 'widget/chat_message_list.dart';
import 'widget/chat_photo_wall.dart';
import 'widget/chat_menu_dialog.dart';

class ChatPage extends ConsumerStatefulWidget {
  final Character? character;

  const ChatPage({
    super.key,
    this.character,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  void initState() {
    super.initState();

    // 初始化聊天数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.character != null) {
        ref.read(chatNotifierProvider.notifier).setCharacter(widget.character!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatNotifierProvider);
    final chatNotifier = ref.read(chatNotifierProvider.notifier);

    return GestureDetector(
      // 点击空白区域收起键盘
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
        chatNotifier.focusNode.unfocus();
      },
      child: Stack(
        children: [
          // 聊天背景
          Positioned.fill(
            child: _buildChatBackground(chatState),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            // 聊天AppBar
            appBar: ChatAppBar.build(
              character: chatState.character,
              isGenerating:
                  chatState.isGeneratingMessage || chatState.isGeneratingImage,
              onCharacterInfoTap: () {
                // TODO: 导航到角色信息页面
                debugPrint('点击角色信息');
              },
              onMenuTap: () {
                _showChatMenu(context, chatState, chatNotifier);
              },
            ),
            body: Column(
              children: [
                // 照片墙
                ChatPhotoWall(
                  chatState: chatState,
                  onToggleVisibility: () {
                    chatNotifier.togglePhotoWallVisibility();
                  },
                  onAddPhoto: () {
                    chatNotifier.addPhotoToWall();
                  },
                  onPhotoTap: (url) {
                    // TODO: 显示照片详情
                    debugPrint('点击照片: $url');
                  },
                ),

                // 消息列表
                ChatMessageList(
                  chatState: chatState,
                  chatNotifier: chatNotifier,
                ),

                // 输入区域
                ChatInput(
                  chatState: chatState,
                  chatNotifier: chatNotifier,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 显示聊天菜单
  void _showChatMenu(
      BuildContext context, ChatState chatState, ChatNotifier chatNotifier) {
    ChatMenuDialog.show(
      context,
      character: chatState.character,
      onStartNewConversation: () {
        chatNotifier.startNewConversation();
      },
      onEditMessage: () {
        chatNotifier.toggleEditMode();
      },
      onRemoveMessage: () {
        chatNotifier.toggleRemoveMode();
      },
      onSaveMemory: () {
        chatNotifier.toggleSaveMode();
      },
      onViewMemory: () {
        // TODO: 导航到记忆列表页面
        debugPrint('查看记忆');
      },
      onWallpaperSettings: () {
        // TODO: 显示壁纸设置
        debugPrint('壁纸设置');
      },
      onReportIssue: () {
        // TODO: 导航到举报页面
        debugPrint('举报问题');
      },
    );
  }

  /// 构建聊天背景
  Widget _buildChatBackground(ChatState chatState) {
    final backgroundUrl = chatState.character?.background;

    // 如果背景URL为空或空字符串，显示默认渐变背景
    if (backgroundUrl == null || backgroundUrl.trim().isEmpty) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F9FA), // 浅灰白色
              Color(0xFFE9ECEF), // 稍深的灰色
            ],
          ),
        ),
      );
    }

    // 有背景URL时，使用CachedNetworkImage处理加载和错误状态
    return CachedNetworkImage(
      imageUrl: backgroundUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F9FA),
              Color(0xFFE9ECEF),
            ],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF007AFF)),
            strokeWidth: 2.0,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF1F3F4), // 稍微不同的灰色调表示错误状态
              Color(0xFFDEE2E6),
            ],
          ),
        ),
      ),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
    );
  }
}
