import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../component/global_text.dart';
import '../../../model/character.dart';
import '../../../util/navigate.dart';

class ChatAppBar {
  static PreferredSize build({
    Character? character,
    bool isGenerating = false,
    VoidCallback? onCharacterInfoTap,
    VoidCallback? onMenuTap,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.5,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        leading: IconButton(
          onPressed: () {
            // 使用 go_router 返回上一页
            Navigate.instance.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF2C2C2E),
            size: 22,
          ),
        ),
        centerTitle: true,
        title: character != null
            ? InkWell(
                onTap: !isGenerating ? onCharacterInfoTap : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 角色头像
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: character.avatar,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 角色名称
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GlobalText(
                          character.name,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1C1C1E),
                        ),
                        if (isGenerating)
                          const GlobalText(
                            '正在输入...',
                            fontSize: 12.0,
                            color: Color(0xFF34C759),
                          ),
                      ],
                    ),
                  ],
                ),
              )
            : const GlobalText(
                '聊天',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1C1E),
              ),
        actions: [
          IconButton(
            onPressed: !isGenerating ? onMenuTap : null,
            icon: Icon(
              Icons.more_horiz,
              color: !isGenerating
                  ? const Color(0xFF2C2C2E)
                  : const Color(0xFF8E8E93),
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
