import 'package:flutter/material.dart';

import 'global_text.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final double? width;

  final double? height;

  final ButtonStyle? style;

  final MainAxisSize mainAxisSize;

  final Widget? iconWidget;

  final EdgeInsetsGeometry? iconPadding;

  final String? text;

  final Color? textColor;

  final double? textFontSize;

  final FontWeight? textFontWeight;

  final double? textHeight;

  final double? textLetterSpacing;

  const GlobalButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    this.style,
    this.mainAxisSize = MainAxisSize.min,
    this.iconWidget,
    this.iconPadding,
    this.text,
    this.textColor,
    this.textFontSize,
    this.textFontWeight,
    this.textHeight,
    this.textLetterSpacing,
  });

  /// 构建 Widget
  ///
  /// 返回一个 ElevatedButton，内部使用 Row 布局来排列图标和文本
  /// 如果只有图标或只有文本，会自动调整布局
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Row(
          // 设置主轴大小，控制 Row 占用的空间
          mainAxisSize: mainAxisSize,
          // 内容居中对齐
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 如果存在图标，则显示图标并添加右边距
            if (iconWidget != null)
              Padding(
                padding: iconPadding ?? EdgeInsets.zero,
                child: iconWidget,
              ),
            // 如果存在文本，则使用 GlobalText 组件显示
            if (text != null)
              GlobalText(
                text!,
                color: textColor,
                fontWeight: textFontWeight,
                fontSize: textFontSize,
                height: textHeight,
                letterSpacing: textLetterSpacing,
              ),
          ],
        ),
      ),
    );
  }
}
