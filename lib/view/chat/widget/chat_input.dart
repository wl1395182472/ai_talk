import 'package:flutter/material.dart';

import '../chat_provider.dart';
import 'idea_dialog.dart';

class ChatInput extends StatelessWidget {
  final ChatState chatState;
  final ChatNotifier chatNotifier;

  const ChatInput({
    super.key,
    required this.chatState,
    required this.chatNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _buildInputContent(context),
    );
  }

  Widget _buildInputContent(BuildContext context) {
    // 特殊模式下的按钮栏
    if (chatState.isEditMode ||
        chatState.isRemoveMode ||
        chatState.isSaveMode) {
      return _buildActionButtonBar();
    }

    // 正常输入模式
    return _buildNormalInputBar(context);
  }

  /// 构建操作按钮栏（编辑/删除/保存模式）
  Widget _buildActionButtonBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // 取消选择按钮（在删除和保存模式下显示）
            if (!chatState.isEditMode)
              Expanded(
                flex: 1,
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      if (chatState.isRemoveMode) {
                        chatNotifier.cancelRemove();
                      } else if (chatState.isSaveMode) {
                        chatNotifier.cancelSave();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F7FA),
                      foregroundColor: const Color(0xFF6B7280),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(
                          color: Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      _getDeselectButtonText(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

            // 主要操作按钮
            Expanded(
              flex: chatState.isEditMode ? 1 : 2,
              child: Container(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (chatState.isEditMode) {
                      _handleEditMessage();
                    } else if (chatState.isRemoveMode) {
                      _handleRemoveMessages();
                    } else if (chatState.isSaveMode) {
                      _handleSaveMessages();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getMainActionButtonColor(),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shadowColor:
                        _getMainActionButtonColor().withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getMainActionButtonIcon(),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getMainActionButtonText(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建正常输入栏
  Widget _buildNormalInputBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 输入框容器
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 44.0,
                  maxHeight: 120.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE8EBF0).withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 输入文本框
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: TextField(
                          controller: chatNotifier.textEditingController,
                          focusNode: chatNotifier.focusNode,
                          enabled: !chatState.isLoading &&
                              !chatState.isGeneratingMessage &&
                              !chatState.isGeneratingImage,
                          style: const TextStyle(
                            color: Color(0xFF1A1D21),
                            fontSize: 16,
                            height: 1.3,
                          ),
                          decoration: const InputDecoration(
                            hintText: '输入消息...',
                            hintStyle: TextStyle(
                              color: Color(0xFF8B95A1),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          maxLines: null,
                          minLines: 1,
                          textInputAction: TextInputAction.newline,
                          onSubmitted: (value) => _sendMessage(),
                        ),
                      ),
                    ),

                    // 想法按钮
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: IconButton(
                        onPressed: chatState.isLoading ||
                                chatState.isGeneratingMessage ||
                                chatState.isGeneratingImage
                            ? null
                            : () {
                                IdeaDialog.show(
                                  context,
                                  chatState: chatState,
                                  chatNotifier: chatNotifier,
                                );
                              },
                        icon: Icon(
                          Icons.lightbulb_outline,
                          color: chatState.isLoading ||
                                  chatState.isGeneratingMessage ||
                                  chatState.isGeneratingImage
                              ? const Color(0xFFBDC3C7)
                              : const Color(0xFF6C7B7F),
                          size: 22,
                        ),
                        iconSize: 22,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 8),

            // 发送按钮
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _getSendButtonColor(),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  if (!_isSendButtonDisabled())
                    BoxShadow(
                      color: _getSendButtonColor().withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: IconButton(
                onPressed: _isSendButtonDisabled() ? null : _sendMessage,
                icon: Icon(
                  _getSendButtonIcon(),
                  color: Colors.white,
                  size: 20,
                ),
                iconSize: 20,
                padding: EdgeInsets.zero,
                splashRadius: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = chatNotifier.textEditingController.text.trim();
    if (text.isNotEmpty) {
      chatNotifier.sendMessage(text);
    }
  }

  // 发送按钮相关的辅助方法
  bool _isSendButtonDisabled() {
    if (chatState.isGeneratingMessage || chatState.isGeneratingImage) {
      return false; // 生成时允许点击（用于停止）
    }
    return chatState.isLoading ||
        chatNotifier.textEditingController.text.trim().isEmpty;
  }

  Color _getSendButtonColor() {
    if (chatState.isGeneratingMessage || chatState.isGeneratingImage) {
      return const Color(0xFFFF6B6B); // 红色表示停止
    }
    if (chatState.isLoading ||
        chatNotifier.textEditingController.text.trim().isEmpty) {
      return const Color(0xFFBDC3C7); // 灰色表示禁用
    }
    return const Color(0xFF4A90E2); // 蓝色表示发送
  }

  IconData _getSendButtonIcon() {
    if (chatState.isGeneratingMessage || chatState.isGeneratingImage) {
      return Icons.stop;
    }
    return Icons.send;
  }

  IconData _getMainActionButtonIcon() {
    if (chatState.isEditMode) {
      return Icons.edit;
    } else if (chatState.isRemoveMode) {
      return Icons.delete;
    } else if (chatState.isSaveMode) {
      return Icons.bookmark;
    }
    return Icons.check;
  }

  void _handleEditMessage() {
    // 实现编辑消息逻辑
    if (chatState.needEditMessage != null) {
      // 将待编辑的消息内容填入输入框
      chatNotifier.textEditingController.text =
          chatState.needEditMessage!.content;
      // 可以在这里添加更多编辑相关的逻辑
      debugPrint('编辑消息: ${chatState.needEditMessage!.content}');
    }
    chatNotifier.cancelEdit();
  }

  void _handleRemoveMessages() {
    // 实现删除消息逻辑
    if (chatState.removeMessageList.isNotEmpty) {
      // 这里可以调用删除API或从本地移除消息
      debugPrint('删除消息: ${chatState.removeMessageList.length}条');
      // TODO: 实现实际的删除逻辑，可能需要调用API
      for (final message in chatState.removeMessageList) {
        debugPrint('删除消息ID: ${message.id}, 内容: ${message.content}');
      }
    }
    chatNotifier.cancelRemove();
  }

  void _handleSaveMessages() {
    // 实现保存消息逻辑
    if (chatState.saveMessageList.isNotEmpty) {
      // 这里可以调用保存到记忆的API
      debugPrint('保存消息: ${chatState.saveMessageList.length}条');
      // TODO: 实现实际的保存到记忆逻辑，调用相应的API
      for (final message in chatState.saveMessageList) {
        debugPrint('保存消息ID: ${message.id}, 内容: ${message.content}');
      }
    }
    chatNotifier.cancelSave();
  }

  String _getDeselectButtonText() {
    if (chatState.isRemoveMode) {
      return chatState.removeMessageList.isEmpty ? '全选' : '取消选择';
    } else if (chatState.isSaveMode) {
      return chatState.saveMessageList.isEmpty ? '全选' : '取消选择';
    }
    return '取消';
  }

  String _getMainActionButtonText() {
    if (chatState.isEditMode) {
      return '保存编辑';
    } else if (chatState.isRemoveMode) {
      return '删除选中';
    } else if (chatState.isSaveMode) {
      return '保存记忆';
    }
    return '确定';
  }

  Color _getMainActionButtonColor() {
    if (chatState.isEditMode) {
      return Colors.blue;
    } else if (chatState.isRemoveMode) {
      return Colors.red;
    } else if (chatState.isSaveMode) {
      return Colors.green;
    }
    return Colors.blue;
  }
}
