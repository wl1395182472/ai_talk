import 'package:flutter/material.dart';

import '../../../component/global_text.dart';
import '../../../component/global_button.dart';
import '../chat_provider.dart';

/// 想法生成对话框
class IdeaDialog extends StatelessWidget {
  final ChatState chatState;
  final ChatNotifier chatNotifier;

  const IdeaDialog({
    super.key,
    required this.chatState,
    required this.chatNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题栏
            Row(
              children: [
                const SizedBox(width: 32), // 平衡右侧关闭按钮
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.yellow,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const GlobalText(
                        '想法助手',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 提示文本
            const GlobalText(
              '为你生成一些对话想法，让聊天更有趣！',
              color: Colors.white70,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // 想法列表
            Flexible(
              child: _buildIdeaList(context),
            ),

            const SizedBox(height: 20),

            // 底部按钮
            if (!chatState.isGeneratingIdea) _buildBottomButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIdeaList(BuildContext context) {
    if (chatState.isGeneratingIdea) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            ),
            SizedBox(height: 16),
            GlobalText(
              '正在生成想法...',
              color: Colors.white70,
            ),
          ],
        ),
      );
    }

    if (chatState.generatedIdeas.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lightbulb_outline,
              size: 48,
              color: Colors.white38,
            ),
            SizedBox(height: 16),
            GlobalText(
              '暂无想法，点击生成按钮获取新想法',
              color: Colors.white54,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: chatState.generatedIdeas.length,
      itemBuilder: (context, index) {
        final idea = chatState.generatedIdeas[index];
        final isSelected = chatState.selectedIdeaIndex == index;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            onTap: () => chatNotifier.selectIdea(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: Colors.blue, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_circle : Icons.lightbulb_outline,
                    color: isSelected ? Colors.blue : Colors.white70,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GlobalText(
                      idea.content,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        // 重新生成按钮
        Expanded(
          child: GlobalButton(
            onPressed: () => chatNotifier.generateIdeas(),
            height: 44,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              side: const BorderSide(color: Colors.white30),
            ),
            text: '重新生成',
            textColor: Colors.white,
          ),
        ),

        const SizedBox(width: 12),

        // 使用想法按钮
        Expanded(
          child: GlobalButton(
            onPressed: chatState.selectedIdeaIndex != null
                ? () => _useSelectedIdea(context)
                : null,
            height: 44,
            style: ElevatedButton.styleFrom(
              backgroundColor: chatState.selectedIdeaIndex != null
                  ? Colors.blue
                  : Colors.grey,
            ),
            text: '使用想法',
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  void _useSelectedIdea(BuildContext context) {
    if (chatState.selectedIdeaIndex != null &&
        chatState.selectedIdeaIndex! < chatState.generatedIdeas.length) {
      final selectedIdea =
          chatState.generatedIdeas[chatState.selectedIdeaIndex!];

      // 检查输入框是否有内容
      final currentText = chatNotifier.textEditingController.text;
      if (currentText.isNotEmpty) {
        // 显示覆盖确认对话框
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('确认替换'),
            content: const Text('当前输入框有内容，是否要替换为选中的想法？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _replaceWithIdea(context, selectedIdea.content);
                },
                child: const Text('替换'),
              ),
            ],
          ),
        );
      } else {
        _replaceWithIdea(context, selectedIdea.content);
      }
    }
  }

  void _replaceWithIdea(BuildContext context, String ideaContent) {
    chatNotifier.textEditingController.text = ideaContent;
    chatNotifier.selectIdea(-1); // 清除选择
    Navigator.of(context).pop();
  }

  /// 显示想法对话框
  static Future<void> show(
    BuildContext context, {
    required ChatState chatState,
    required ChatNotifier chatNotifier,
  }) {
    return showDialog(
      context: context,
      builder: (context) => IdeaDialog(
        chatState: chatState,
        chatNotifier: chatNotifier,
      ),
    );
  }
}
