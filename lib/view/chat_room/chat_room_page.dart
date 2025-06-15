import 'package:ai_talk/component/global_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Consumer, WidgetRef;
import 'package:go_router/go_router.dart';

import '../../model/chat_room.dart';
import 'chat_room_provider.dart';

class ChatRoomPage extends StatefulWidget {
  final ChatRoom? chatRoom;

  const ChatRoomPage({
    super.key,
    this.chatRoom,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final provider = ref.read(chatRoomNotifier);
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  widget.chatRoom?.background ?? '',
                ),
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.25),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: SizedBox(),
                centerTitle: true,
                title: GlobalText(
                  widget.chatRoom?.title ?? 'Chat Room',
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              body: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    // 可折叠的聊天室简介
                    _buildDescriptionSection(),
                    // 角色头像展示区域
                    _buildCharacterAvatarsSection(),
                    // 在线人数区域
                    _buildOnlineUsersSection(ref),
                    // 聊天消息区域
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            // 这里可以添加聊天消息列表
                            Expanded(
                              child: Center(
                                child: GlobalText(
                                  '开始聊天吧！',
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 底部区域
                    _buildBottomArea(provider),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomArea(provider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 警告信息
          _buildWarningMessage(),
          const SizedBox(height: 12),
          // 输入框和功能按钮
          _buildInputArea(provider),
        ],
      ),
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            color: Colors.orange,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GlobalText(
              '欢迎来到聊天室！平台严禁未成年人开播并发布任何危害未成年人安全的内容；禁止任何与暴力、色情、赌博以及违法行为等有关内容的行为和言论，如有发现请及时举报',
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 10,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // 表情按钮
          _buildActionButton(
            icon: Icons.emoji_emotions_outlined,
            onTap: provider.onClickIdea,
            color: Colors.amber,
          ),
          const SizedBox(width: 8),
          // 输入框
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: '说点什么...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              maxLines: 3,
              minLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          // 用户资料按钮
          _buildActionButton(
            icon: Icons.person_outline,
            onTap: provider.onClickProfile,
            color: Colors.blue,
          ),
          const SizedBox(width: 8),
          // 发送按钮
          _buildActionButton(
            icon: Icons.send_rounded,
            onTap: provider.onClickSend,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _isDescriptionExpanded = !_isDescriptionExpanded;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GlobalText(
                        '聊天室简介',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    AnimatedRotation(
                      turns: _isDescriptionExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: GlobalText(
                    widget.chatRoom?.scenario ?? '',
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                    textAlign: TextAlign.left,
                  ),
                ),
                crossFadeState: _isDescriptionExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterAvatarsSection() {
    // 直接使用聊天室中的角色数据
    final List<GroupCharacter> characters = widget.chatRoom?.characters ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: GlobalText(
                      '参与角色',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        // 添加自己
                        _buildCharacterAvatar('', '我', 'self'),
                        // 显示聊天室角色
                        ...characters.map((character) => _buildCharacterAvatar(
                              character.avatar,
                              character.name,
                              'ai',
                            )),
                        // 添加按钮
                        _buildAddButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineUsersSection(WidgetRef ref) {
    // 使用聊天室中的角色数据
    final List<GroupCharacter> characters = widget.chatRoom?.characters ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          radius: 18,
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
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  final notifier = ref.read(chatRoomNotifier);
                  notifier.onClickShowCharacterList(context, widget.chatRoom);
                },
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.people,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterAvatar(String avatarUrl, String name, String type) {
    Color borderColor;
    switch (type) {
      case 'self':
        borderColor = Colors.green;
        break;
      case 'ai':
        borderColor = Colors.blue;
        break;
      case 'user':
        borderColor = Colors.orange;
        break;
      default:
        borderColor = Colors.white;
    }

    return SizedBox(
      width: 50,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 2),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: avatarUrl.isNotEmpty
                  ? CachedNetworkImageProvider(avatarUrl)
                  : null,
              backgroundColor: Colors.grey.withValues(alpha: 0.3),
              child: avatarUrl.isEmpty
                  ? Icon(
                      type == 'self' ? Icons.person : Icons.smart_toy,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            name,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showAddCharacterDialog();
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '添加',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddCharacterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withValues(alpha: 0.9),
          title: GlobalText(
            '添加角色',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person_add_alt_1, color: Colors.green),
                title: GlobalText('Invite a real friend', color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                  _showOnlineUsersDialog();
                },
              ),
              ListTile(
                leading: Icon(Icons.smart_toy, color: Colors.blue),
                title: GlobalText('AI Character List', color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: 实现AI角色列表逻辑
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outline, color: Colors.orange),
                title: GlobalText('Quick Create a New Character',
                    color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: 实现快速创建新角色逻辑
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOnlineUsersDialog() {
    // 模拟在线用户数据
    final List<Map<String, dynamic>> onlineUsers = [
      {'name': '张三', 'avatar': 'https://example.com/avatar1.png', 'id': 1},
      {'name': '李四', 'avatar': 'https://example.com/avatar2.png', 'id': 2},
      {'name': '王五', 'avatar': 'https://example.com/avatar3.png', 'id': 3},
      {'name': '赵六', 'avatar': 'https://example.com/avatar4.png', 'id': 4},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withValues(alpha: 0.9),
          title: GlobalText(
            '邀请好友',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GlobalText(
                  '选择要邀请的好友',
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
                const SizedBox(height: 16),
                ...onlineUsers.map((user) => ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            CachedNetworkImageProvider(user['avatar']),
                        backgroundColor: Colors.grey.withValues(alpha: 0.3),
                      ),
                      title: GlobalText(
                        user['name'],
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _sendInvitation(user['name'], user['id']);
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  void _sendInvitation(String userName, int userId) {
    // TODO: 实现发送邀请逻辑
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withValues(alpha: 0.9),
          title: GlobalText(
            '邀请已发送',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          content: GlobalText(
            '已向 $userName 发送邀请',
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: GlobalText(
                '确定',
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }
}
