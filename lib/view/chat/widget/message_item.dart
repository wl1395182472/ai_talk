import 'package:flutter/material.dart';

import '../../../model/chat_message.dart';
import '../chat_provider.dart';

class MessageItem extends StatelessWidget {
  final ChatMessage message;
  final ChatState chatState;
  final ChatNotifier chatNotifier;
  final int messageIndex;

  const MessageItem({
    super.key,
    required this.message,
    required this.chatState,
    required this.chatNotifier,
    required this.messageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == 'user';
    final isSelected = _isMessageSelected();

    // 添加调试信息
    debugPrint(
        'MessageItem build: Type=${message.type}, IsUser=$isUser, Content=${message.content.length > 30 ? "${message.content.substring(0, 30)}..." : message.content}');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI头像 (左侧)
          if (!isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],

          // 消息内容
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color(0xFF007AFF) // 苹果蓝色
                    : const Color(0xFFF2F2F7), // 浅灰色背景
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 消息文本
                  SelectableText(
                    message.content,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isUser ? Colors.white : const Color(0xFF1C1C1E),
                      height: 1.4,
                    ),
                  ),

                  // 时间戳
                  const SizedBox(height: 6),
                  Text(
                    _formatTimestamp(message.createdAt),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: isUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : const Color(0xFF8E8E93),
                    ),
                  ),

                  // 图片 (如果有) - 暂时注释掉，因为chat_message.dart中没有imageUrl
                  // TODO: 如果需要支持图片消息，需要扩展ChatMessage模型
                  /*
                  if (message.imageUrl != null) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: message.imageUrl!,
                        width: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 200,
                          height: 150,
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 200,
                          height: 150,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                  */

                  // 语音播放按钮 (如果有) - 暂时注释掉，因为chat_message.dart中没有audioUrl
                  // TODO: 如果需要支持语音消息，需要扩展ChatMessage模型
                  /*
                  if (message.audioUrl != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _playAudio(),
                          icon: Icon(
                            chatState.currentPlayingVoiceMessage?.id ==
                                    message.id
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: isUser
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '语音消息',
                          style: TextStyle(
                            fontSize: 14,
                            color: isUser ? Colors.white70 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                  */
                ],
              ),
            ),
          ),

          // 选择框 (编辑/删除/保存模式)
          if (_showSelectionMode()) ...[
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF007AFF)
                      : const Color(0xFFD1D1D6),
                  width: 2,
                ),
                color:
                    isSelected ? const Color(0xFF007AFF) : Colors.transparent,
              ),
              child: IconButton(
                onPressed: () => _toggleSelection(),
                icon: Icon(
                  isSelected ? Icons.check : null,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],

          // 用户头像 (右侧)
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF007AFF), Color(0xFF5856D6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTimestamp(String? createdAt) {
    if (createdAt == null) return '未知时间';

    try {
      final timestamp = DateTime.parse(createdAt);
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      if (difference.inDays > 0) {
        return '${difference.inDays}天前';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}小时前';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}分钟前';
      } else {
        return '刚刚';
      }
    } catch (e) {
      return '未知时间';
    }
  }

  bool _showSelectionMode() {
    return chatState.isEditMode ||
        chatState.isRemoveMode ||
        chatState.isSaveMode;
  }

  bool _isMessageSelected() {
    if (chatState.isEditMode) {
      return chatState.needEditMessage?.id == message.id;
    } else if (chatState.isRemoveMode) {
      return chatState.removeMessageList.contains(message);
    } else if (chatState.isSaveMode) {
      return chatState.saveMessageList.contains(message);
    }
    return false;
  }

  void _toggleSelection() {
    if (chatState.isEditMode) {
      chatNotifier.editMessage(message);
    } else if (chatState.isRemoveMode) {
      chatNotifier.removeMessage(message);
    } else if (chatState.isSaveMode) {
      chatNotifier.saveMessageToMemory(message);
    }
  }
}
