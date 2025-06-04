import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../util/log.dart';

class UrlImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final bool needLoading;
  final Widget? errorWidget;

  const UrlImage(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.fit,
      this.alignment = Alignment.center,
      this.needLoading = true,
      this.errorWidget});

  @override
  State<UrlImage> createState() => _UrlImageState();
}

class _UrlImageState extends State<UrlImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? BoxFit.cover,
      alignment: widget.alignment,
      placeholder: widget.needLoading
          ? (context, url) => Center(
                child: CircularProgressIndicator(),
              )
          : null,
      errorWidget: (context, url, error) {
        Log.instance.logger.e('Failed to load image from URL: $url');
        return widget.errorWidget ?? Icon(Icons.error);
      },
    );
  }
}
