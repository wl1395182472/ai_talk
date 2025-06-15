import 'package:flutter/material.dart';

import '../../../component/global_text.dart';
import '../chat_provider.dart';

/// 聊天操作栏 - 包含重新生成、生成图片等操作
class ChatOperationBar extends StatelessWidget {
  final ChatState chatState;
  final ChatNotifier chatNotifier;

  const ChatOperationBar({
    super.key,
    required this.chatState,
    required this.chatNotifier,
  });

  @override
  Widget build(BuildContext context) {
    // 只有在有消息且不在特殊模式下才显示操作栏
    if (chatState.messageList.length <= 1 ||
        chatState.isGeneratingMessage ||
        chatState.isGeneratingImage ||
        chatState.isEditMode ||
        chatState.isRemoveMode ||
        chatState.isSaveMode ||
        chatState.isLoading) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          // 重新生成消息导航 (如果有多个版本)
          if (chatState.regenerateMessageList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  // 上一个版本
                  if (chatState.regenerateMessageIndex > 0)
                    IconButton(
                      onPressed: () => _navigateRegenerateMessage(-1),
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white70,
                        size: 28,
                      ),
                    )
                  else
                    const SizedBox(width: 48),

                  const Spacer(),

                  // 版本指示器
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GlobalText(
                      '${chatState.regenerateMessageIndex + 1}/${chatState.regenerateMessageList.length}',
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),

                  const Spacer(),

                  // 下一个版本
                  if (chatState.regenerateMessageIndex <
                      chatState.regenerateMessageList.length - 1)
                    IconButton(
                      onPressed: () => _navigateRegenerateMessage(1),
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Colors.white70,
                        size: 28,
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),

          // 操作按钮行
          Row(
            children: [
              // 想法按钮
              _buildActionButton(
                icon: Icons.lightbulb_outline,
                onPressed: chatState.isGeneratingImage
                    ? null
                    : () {
                        // TODO: 生成想法
                        chatNotifier.generateIdeas();
                      },
                hasNotification: false,
              ),

              const SizedBox(width: 10.0),

              // 图片按钮
              _buildActionButton(
                icon: Icons.image_outlined,
                onPressed: chatState.isGeneratingImage
                    ? null
                    : () {
                        chatNotifier.generateImage();
                      },
                hasNotification: chatState.isGeneratingImage,
              ),

              const SizedBox(width: 10.0),

              // 重新生成按钮
              _buildActionButton(
                icon: Icons.refresh,
                onPressed: !chatState.isGeneratingMessage &&
                        !chatState.isGeneratingImage
                    ? () {
                        chatNotifier.regenerateMessage();
                      }
                    : null,
                hasNotification: chatState.isGeneratingMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onPressed,
    bool hasNotification = false,
  }) {
    return SizedBox(
      width: 25.0,
      height: 25.0,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              size: 25,
              color: onPressed != null
                  ? const Color(0xFF007AFF)
                  : const Color(0xFF8E8E93),
            ),
            if (hasNotification)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF3B30),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateRegenerateMessage(int direction) {
    // TODO: 实现重新生成消息导航逻辑
    final newIndex = chatState.regenerateMessageIndex + direction;
    if (newIndex >= 0 && newIndex < chatState.regenerateMessageList.length) {
      // chatNotifier.setRegenerateMessageIndex(newIndex);
    }
  }
}
