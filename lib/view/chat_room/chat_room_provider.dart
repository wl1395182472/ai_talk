import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../api/api.dart';
import '../../component/global_text.dart';
import '../../model/chat_room.dart';
import '../../util/log.dart';

class ChatRoomNotifier extends ChangeNotifier {
  List<ChatRoom> _chatRooms = [];
  bool _isLoading = false;
  String? _error;

  List<ChatRoom> get chatRooms => _chatRooms;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ChatRoomNotifier() {
    _initialize();
  }

  void onClickShowCharacterList(BuildContext context, ChatRoom? chatRoom) {
    Log.instance.logger.i('点击显示角色列表');

    final characters = chatRoom?.characters ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withValues(alpha: 0.9),
          title: GlobalText(
            '角色列表',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Column(
              children: [
                GlobalText(
                  '当前聊天室的所有角色',
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: character.avatar.isNotEmpty
                              ? CachedNetworkImageProvider(character.avatar)
                              : null,
                          backgroundColor: Colors.grey.withValues(alpha: 0.3),
                          child: character.avatar.isEmpty
                              ? Icon(
                                  Icons.smart_toy,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        ),
                        title: GlobalText(
                          character.name,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: GlobalText(
                '关闭',
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }

  void onClickProfile() {
    Log.instance.logger.i('点击用户资料按钮');
    // TODO: 实现用户资料相关逻辑
  }

  void onClickIdea() {
    Log.instance.logger.i('点击想法按钮');
    // TODO: 实现想法相关逻辑
  }

  void onClickSend() {
    Log.instance.logger.i('点击发送按钮');
    // TODO: 实现发送消息逻辑
  }

  Future<void> _initialize() async {
    await fetchChatRooms();
  }

  Future<void> fetchChatRooms() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.instance.group.getHomePageGroups(
        limit: 20,
        pageNo: 1,
      );

      if (response.code == 0) {
        if (response.result is List) {
          _chatRooms = (response.result as List)
              .map((item) =>
                  item is Map<String, dynamic> ? ChatRoom.fromJson(item) : null)
              .where((item) => item != null)
              .cast<ChatRoom>()
              .toList();
          Log.instance.logger.i('拉取到聊天室数据: ${_chatRooms.length} 个聊天室');
        } else {
          _chatRooms = [];
          Log.instance.logger.w('拉取聊天室数据成功，但结果不是列表类型');
        }

        // 打印每个聊天室的详细信息
        for (int i = 0; i < _chatRooms.length; i++) {
          final chatRoom = _chatRooms[i];
          Log.instance.logger.i('''
聊天室 ${i + 1}:
  ID: ${chatRoom.groupId}
  标题: ${chatRoom.title}
  场景: ${chatRoom.scenario}
  创建者: ${chatRoom.creater}
  生成次数: ${chatRoom.genCount}
  角色数量: ${chatRoom.characters.length}
          ''');
        }
      } else {
        _error = response.msg;
        Log.instance.logger.e('拉取聊天室数据失败: ${response.msg}');
      }
    } catch (error, stackTrace) {
      _error = error.toString();
      Log.instance.logger.e(
        '拉取聊天室数据出错',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

final chatRoomNotifier = ChangeNotifierProvider<ChatRoomNotifier>((ref) {
  return ChatRoomNotifier();
});
