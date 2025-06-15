import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../chat_provider.dart';

class ChatPhotoWall extends StatelessWidget {
  final ChatState chatState;
  final VoidCallback onToggleVisibility;
  final VoidCallback onAddPhoto;
  final Function(String) onPhotoTap;

  const ChatPhotoWall({
    super.key,
    required this.chatState,
    required this.onToggleVisibility,
    required this.onAddPhoto,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 照片列表
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.maxFinite,
          height: chatState.isPhotoWallVisible &&
                  (chatState.photoUrls.isNotEmpty || _canAddPhoto())
              ? 100.0
              : 0.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            itemCount: chatState.photoUrls.length + (_canAddPhoto() ? 1 : 0),
            itemBuilder: (context, index) {
              // 如果可以添加照片且是第一个item，显示添加按钮
              if (_canAddPhoto() && index == 0) {
                return Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: onAddPhoto,
                    borderRadius: BorderRadius.circular(10.0),
                    child: const Icon(
                      Icons.add_photo_alternate,
                      size: 32,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              // 显示照片
              final photoIndex = _canAddPhoto() ? index - 1 : index;
              final photoUrl = chatState.photoUrls[photoIndex];

              return Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () => onPhotoTap(photoUrl),
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: photoUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                      // 半透明遮罩
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // 展开/收起按钮
        if (chatState.photoUrls.isNotEmpty || _canAddPhoto())
          InkWell(
            onTap: onToggleVisibility,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4.0),
              bottomRight: Radius.circular(4.0),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 30.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.fill,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    key: ValueKey(chatState.isPhotoWallVisible),
                    chatState.isPhotoWallVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  bool _canAddPhoto() {
    // TODO: 实现判断是否可以添加照片的逻辑
    // 例如：当前用户是角色的创建者
    return true;
  }
}
