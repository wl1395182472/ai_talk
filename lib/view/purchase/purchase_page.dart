import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget;

import 'widget/payment_background.dart';
import 'widget/payment_appbar.dart';
import 'widget/payment_switch.dart';
import 'widget/payment_product.dart';
import 'widget/payment_button.dart';
import 'widget/payment_privacy.dart';

import 'purchase_provider.dart' show purchaseProvider;
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../model/product.dart' show Product;

class PurchasePage extends ConsumerStatefulWidget {
  const PurchasePage({super.key});

  @override
  ConsumerState<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends ConsumerState<PurchasePage> {
  bool isConsumable = false;
  int consumableIndex = 0;
  int nonConsumableIndex = 0;
  bool isProPlus = true;
  int currentImageIndex =
      0; // Added to track current image index for background

  @override
  void initState() {
    super.initState();
    // It's good practice to trigger data loading for providers if not already handled by autoDispose/family.
    // However, PurchaseNotifier already loads products and images in its constructor/init.
  }

  void onIndexChanged(int index) {
    setState(() {
      // currentImage = 'new_image_path_$index.png'; // This will be handled by the image list from provider
      currentImageIndex = index;
    });
  }

  void onIsYearChanged() {
    setState(() {
      isProPlus = !isProPlus;
    });
  }

  void onChangedConsumable(int index) {
    setState(() {
      consumableIndex = index;
    });
  }

  void onChangedNonConsumable(int index) {
    setState(() {
      nonConsumableIndex = index;
    });
  }

  void onClickRestore() {
    ref.read(purchaseProvider.notifier).restorePurchase();
  }

  void onClickChangeIsConsumable(bool value) {
    if (isConsumable != value) {
      setState(() {
        isConsumable = value;
      });
    }
  }

  void _handlePurchase() {
    final provider = ref.read(purchaseProvider.notifier);
    List<ProductDetails> productsToConsider = isConsumable
        ? ref.read(purchaseProvider).consumableProducts
        : ref.read(purchaseProvider).subscriptionProducts;

    int currentIndex = isConsumable ? consumableIndex : nonConsumableIndex;

    if (currentIndex < productsToConsider.length) {
      final productDetails = productsToConsider[currentIndex];
      final Product? productToPurchase =
          Product.fromProductDetails(productDetails);
      if (productToPurchase != null) {
        provider.setSelectedProduct(productToPurchase);
        provider.purchaseProduct();
      } else {}
    } else {}
  }

  ConsumableProduct _toConsumableProductForUI(ProductDetails pd) {
    return ConsumableProduct(
      id: pd.id,
      title: pd.title,
      description: pd.description,
      price: pd.price,
      rawPrice: pd.rawPrice,
      currencyCode: pd.currencyCode,
      currencySymbol: pd.currencySymbol,
      tokenAmount: 100, // Example
    );
  }

  NonConsumableProduct _toNonConsumableProductForUI(ProductDetails pd) {
    // Assuming default values or logic to determine planType and userCurrentLevel
    return NonConsumableProduct(
      id: pd.id,
      title: pd.title,
      description: pd.description,
      price: pd.price,
      rawPrice: pd.rawPrice,
      currencyCode: pd.currencyCode,
      currencySymbol: pd.currencySymbol,
      planType: "monthly", // Placeholder
      userCurrentLevel: 1, // Placeholder
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerState = ref.watch(purchaseProvider);
    final paymentImages = providerState.paymentImages;

    final List<ConsumableProduct> consumableProductListForUI = providerState
        .consumableProducts
        .map(_toConsumableProductForUI)
        .toList();
    final List<NonConsumableProduct> nonConsumableProductListForUI =
        providerState.subscriptionProducts
            .map(_toNonConsumableProductForUI)
            .toList();

    return Scaffold(
      body: Stack(
        children: [
          // Background image display
          PaymentBackground(
            imageUrls: paymentImages, // Pass images from provider
            onIndexChanged: onIndexChanged,
            isConsumable: isConsumable,
            consumableIndex: consumableIndex,
            nonConsumableIndex: nonConsumableIndex,
            isProPlus: isProPlus,
            isLoadingProducts: providerState.isLoading,
            onClickChangeIsConsumable: onClickChangeIsConsumable,
          ),
          // Main content area
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                PaymentAppBar(
                  isConsumable: isConsumable,
                  consumableIndex: consumableIndex,
                  nonConsumableIndex: nonConsumableIndex,
                  isProPlus: isProPlus,
                  onClickRestore: onClickRestore,
                ),
                PaymentSwitch(
                  isConsumable: isConsumable,
                  isProPlus: isProPlus,
                  onIsYearChanged: onIsYearChanged,
                ),
                const Spacer(),
                PaymentProduct(
                  isProPlus: isProPlus,
                  isLoadingProducts: providerState.isLoading,
                  isConsumable: isConsumable,
                  consumableIndex: consumableIndex,
                  nonConsumableIndex: nonConsumableIndex,
                  consumableProductList: consumableProductListForUI,
                  nonConsumableProductList: nonConsumableProductListForUI,
                  onChangedConsumable: onChangedConsumable,
                  onChangedNonconsumable: onChangedNonConsumable,
                ),
                PaymentButton(
                  isConsumable: isConsumable,
                  isLoadingProducts: providerState.isLoading,
                  onClickPurchase: _handlePurchase,
                ),
                const PaymentPrivacy(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
