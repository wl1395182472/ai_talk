import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../chat_provider.dart';
import 'message_item.dart';
import 'chat_operation_bar.dart';

class ChatMessageList extends StatelessWidget {
  final ChatState chatState;
  final ChatNotifier chatNotifier;

  const ChatMessageList({
    super.key,
    required this.chatState,
    required this.chatNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        scrollController: chatNotifier.scrollController,
        controller: chatNotifier.refreshController,
        enablePullDown: !chatState.isGeneratingMessage &&
            !chatState.isGeneratingImage &&
            !chatState.isEditMode &&
            !chatState.isRemoveMode &&
            !chatState.isSaveMode,
        enablePullUp: !chatState.isGeneratingMessage &&
            !chatState.isGeneratingImage &&
            !chatState.isEditMode &&
            !chatState.isRemoveMode &&
            !chatState.isSaveMode,
        onRefresh: chatNotifier.handleRefresh,
        onLoading: chatNotifier.handleLoadMore,
        header: const WaterDropHeader(),
        reverse: true,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          reverse: true,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: index == 0 ? 5 : 10),
          itemCount: chatState.messageList.length + 2,
          itemBuilder: (BuildContext context, int index) {
            // 最底部：操作栏
            if (index == 0) {
              return ChatOperationBar(
                chatState: chatState,
                chatNotifier: chatNotifier,
              );
            }
            // 最顶部：提示信息
            else if (index == chatState.messageList.length + 1) {
              return chatState.messageList.isEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE5E5EA),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        '和AI开始你的对话吧！✨',
                        style: TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox();
            }
            // 消息项
            else {
              final messageIndex = index - 1;
              final message = chatState.messageList[messageIndex];

              // 添加调试信息
              debugPrint(
                  'Rendering message $messageIndex: Type=${message.type}, Content=${message.content.length > 30 ? message.content.substring(0, 30) + "..." : message.content}');

              return MessageItem(
                message: message,
                chatState: chatState,
                chatNotifier: chatNotifier,
                messageIndex: messageIndex,
              );
            }
          },
        ),
      ),
    );
  }
}
