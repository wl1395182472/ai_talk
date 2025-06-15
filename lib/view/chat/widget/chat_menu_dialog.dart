import 'package:flutter/material.dart';

import '../../../component/global_text.dart';
import '../../../model/character.dart';

/// 聊天菜单对话框
class ChatMenuDialog extends StatelessWidget {
  final Character? character;
  final VoidCallback? onStartNewConversation;
  final VoidCallback? onEditMessage;
  final VoidCallback? onRemoveMessage;
  final VoidCallback? onSaveMemory;
  final VoidCallback? onViewMemory;
  final VoidCallback? onWallpaperSettings;
  final VoidCallback? onReportIssue;

  const ChatMenuDialog({
    super.key,
    this.character,
    this.onStartNewConversation,
    this.onEditMessage,
    this.onRemoveMessage,
    this.onSaveMemory,
    this.onViewMemory,
    this.onWallpaperSettings,
    this.onReportIssue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 角色信息
            if (character != null) ...[
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      character!.avatar,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          character!.name,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        GlobalText(
                          character!.shortDescription,
                          fontSize: 14,
                          color: Colors.white70,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white24),
              const SizedBox(height: 16),
            ],

            // 菜单选项
            _buildMenuItem(
              icon: Icons.fiber_new_rounded,
              title: '开始新对话',
              onTap: () {
                Navigator.of(context).pop();
                onStartNewConversation?.call();
              },
            ),
            _buildMenuItem(
              icon: Icons.edit_document,
              title: '编辑消息',
              onTap: () {
                Navigator.of(context).pop();
                onEditMessage?.call();
              },
            ),
            _buildMenuItem(
              icon: Icons.delete_outline,
              title: '删除消息',
              onTap: () {
                Navigator.of(context).pop();
                onRemoveMessage?.call();
              },
            ),
            _buildMenuItem(
              icon: Icons.save_rounded,
              title: '保存记忆',
              onTap: () {
                Navigator.of(context).pop();
                onSaveMemory?.call();
              },
            ),
            _buildMenuItem(
              icon: Icons.remove_red_eye_rounded,
              title: '查看记忆',
              onTap: () {
                Navigator.of(context).pop();
                onViewMemory?.call();
              },
            ),
            _buildMenuItem(
              icon: Icons.wallpaper_rounded,
              title: '壁纸设置',
              onTap: () {
                Navigator.of(context).pop();
                onWallpaperSettings?.call();
              },
            ),
            if (character != null) // 只有当角色不是当前用户创建时才显示举报选项
              _buildMenuItem(
                icon: Icons.report_problem_rounded,
                title: '举报问题',
                onTap: () {
                  Navigator.of(context).pop();
                  onReportIssue?.call();
                },
              ),

            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),

            // 取消按钮
            _buildMenuItem(
              icon: Icons.close,
              title: '取消',
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white70,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlobalText(
                  title,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 显示菜单对话框
  static Future<void> show(
    BuildContext context, {
    Character? character,
    VoidCallback? onStartNewConversation,
    VoidCallback? onEditMessage,
    VoidCallback? onRemoveMessage,
    VoidCallback? onSaveMemory,
    VoidCallback? onViewMemory,
    VoidCallback? onWallpaperSettings,
    VoidCallback? onReportIssue,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ChatMenuDialog(
        character: character,
        onStartNewConversation: onStartNewConversation,
        onEditMessage: onEditMessage,
        onRemoveMessage: onRemoveMessage,
        onSaveMemory: onSaveMemory,
        onViewMemory: onViewMemory,
        onWallpaperSettings: onWallpaperSettings,
        onReportIssue: onReportIssue,
      ),
    );
  }
}
