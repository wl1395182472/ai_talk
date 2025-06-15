import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'payment_description.dart';

class GlobalImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const GlobalImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    // Basic image loading, replace with your actual GlobalImage features (caching, placeholders, etc.)
    if (url.startsWith('http')) {
      return Image.network(url, width: width, height: height, fit: fit);
    } else {
      return Image.asset(url, width: width, height: height, fit: fit);
    }
  }
}

class PaymentUtil {
  static List<String> paymentImageList = [];
}

class PaymentBackground extends StatelessWidget {
  final List<String> imageUrls;
  final void Function(int) onIndexChanged;
  // Whether products are loading
  final bool isLoadingProducts;
  // Indicates if the product is consumable
  final bool isConsumable;
  // Index for consumable products
  final int consumableIndex;
  // Index for non-consumable products
  final int nonConsumableIndex;
  final bool isProPlus;
  // Callback for changing consumable state
  final void Function(bool) onClickChangeIsConsumable;

  const PaymentBackground({
    super.key,
    required this.imageUrls, // Changed from url to imageUrls
    required this.onIndexChanged,
    required this.isLoadingProducts,
    required this.isConsumable,
    required this.consumableIndex,
    required this.nonConsumableIndex,
    required this.isProPlus,
    required this.onClickChangeIsConsumable,
  });

  @override
  String toStringShort() {
    return 'PaymentBackground';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          imageUrls.isEmpty // Added check for empty list
              ? Center(
                  child: CircularProgressIndicator()) // Show loader if empty
              : Swiper(
                  autoplay: true,
                  viewportFraction: 1.0,
                  scale: 1.0,
                  onIndexChanged: onIndexChanged, // Use the passed callback
                  itemCount: imageUrls.length, // Use imageUrls.length
                  itemBuilder: (BuildContext context, int index) => GlobalImage(
                    url: imageUrls.elementAtOrNull(index) ?? '',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 3 / 5,
                    fit: BoxFit.cover,
                  ),
                ),
          Positioned(
            top: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: PaymentDescription(
              isConsumable: isConsumable,
              consumableIndex: consumableIndex,
              nonConsumableIndex: nonConsumableIndex,
              isProPlus: isProPlus,
              isLoadingProducts: isLoadingProducts,
              onClickChangeIsConsumable: onClickChangeIsConsumable,
            ),
          ),
        ],
      ),
    );
  }
}
