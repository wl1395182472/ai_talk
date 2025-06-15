import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart'; // Assuming SpinKit is used
// import 'package:get/get.dart'; // Assuming Get is not used or will be replaced

import '../../../component/global_text.dart';
// import '../../../component/left_arrow_clipper.dart'; // Assuming LeftArrowClipper is used or will be replaced
// import '../../../component/trapezoid_widget.dart'; // Assuming TrapezoidWidget is used or will be replaced
// import '../../../models/consumable_product.dart'; // Replace with your actual model
// import '../../../models/nonconsumable_product.dart'; // Replace with your actual model
// import '../../../tools/tool_util.dart'; // Assuming ToolUtil is used or will be replaced
// import '../../../tools/user_util.dart'; // Assuming UserUtil is used or will be replaced
// import '../../../component/shimmer_effect.dart'; // Assuming ShimmerEffect is used or will be replaced

// --- Placeholder Models (Replace with your actual models) ---
// Ensure these models are compatible with how ProductDetails from in_app_purchase is transformed.
class ConsumableProduct {
  final String id;
  final String title;
  final String description;
  final String price; // Formatted price string
  final double rawPrice; // Raw price for calculations
  final String currencyCode;
  final String currencySymbol;
  // Add any other fields your UI needs, e.g., token amount
  final int tokenAmount;

  ConsumableProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rawPrice,
    required this.currencyCode,
    required this.currencySymbol,
    required this.tokenAmount,
  });
}

class NonConsumableProduct {
  final String id;
  final String title;
  final String description;
  final String price; // Formatted price string
  final double rawPrice; // Raw price for calculations
  final String currencyCode;
  final String currencySymbol;
  // Add any other fields your UI needs, e.g., plan type (monthly/yearly), features
  final String planType; // e.g., "Monthly", "Yearly"
  final int
      userCurrentLevel; // For Pro/Pro+ differentiation if needed by this widget directly

  NonConsumableProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rawPrice,
    required this.currencyCode,
    required this.currencySymbol,
    required this.planType,
    required this.userCurrentLevel,
  });
}
// --- End Placeholder Models ---

// --- Placeholder for SpinKit (if you don't have it or want a simpler loader) ---
class SpinKitSpinningLines extends StatelessWidget {
  final Color color;
  final double size;
  const SpinKitSpinningLines(
      {super.key, required this.color, this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}
// --- End Placeholder for SpinKit ---

class PaymentProduct extends StatelessWidget {
  final bool
      isProPlus; // To differentiate between Pro and Pro+ subscription views if needed
  final bool isLoadingProducts;
  final bool isConsumable;
  final int consumableIndex; // Currently selected consumable product index
  final int
      nonConsumableIndex; // Currently selected non-consumable product index

  // Use the placeholder models. Ensure these are populated correctly in PurchasePage.
  final List<ConsumableProduct> consumableProductList;
  final List<NonConsumableProduct>
      nonConsumableProductList; // Combined list for subscriptions

  // These might be redundant if nonConsumableProductList is already filtered in PurchasePage
  // final RxList<NonConsumableProduct> proList;
  // final RxList<NonConsumableProduct> proPlusList;

  final void Function(int) onChangedConsumable;
  final void Function(int) onChangedNonconsumable;
  // final void Function(bool) onClickChangeIsConsumable; // This seems to be handled by arrows in PaymentDescription

  const PaymentProduct({
    super.key,
    required this.isProPlus,
    required this.isLoadingProducts,
    required this.isConsumable,
    required this.consumableIndex,
    required this.nonConsumableIndex,
    required this.onChangedConsumable,
    required this.onChangedNonconsumable,
    required this.consumableProductList,
    required this.nonConsumableProductList, // Changed from RxList
    // required this.proList,
    // required this.proPlusList,
    // required this.onClickChangeIsConsumable,
  });

  @override
  String toStringShort() {
    return 'PaymentProduct';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingProducts) {
      return SizedBox(
        height: 152.0, // Maintain consistent height
        child: SpinKitSpinningLines(
          // Using placeholder SpinKit
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ),
      );
    }

    List<Widget> productWidgets;
    if (isConsumable) {
      productWidgets = consumableProductList
          .asMap()
          .entries
          .map((entry) => _buildConsumableItem(context, entry.value, entry.key))
          .toList();
    } else {
      // Filter nonConsumableProductList based on isProPlus if necessary,
      // or assume it's already filtered in PurchasePage.
      // For this example, we'll iterate through the whole nonConsumableProductList
      // and the selection is handled by nonConsumableIndex.
      productWidgets = nonConsumableProductList
          .asMap()
          .entries
          .map((entry) =>
              _buildNonConsumableItem(context, entry.value, entry.key))
          .toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Column(
        children: productWidgets,
      ),
    );
  }

  Widget _buildConsumableItem(
      BuildContext context, ConsumableProduct product, int index) {
    final bool isSelected = consumableIndex == index;
    return GestureDetector(
      onTap: () => onChangedConsumable(index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.pink.withValues(alpha: 0.2)
              : Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
          border: isSelected ? Border.all(color: Colors.pink, width: 2) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(product.title,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
                GlobalText(product.description,
                    fontSize: 12, color: Colors.black),
                GlobalText("${product.tokenAmount} Tokens",
                    fontSize: 14, color: Colors.amber),
              ],
            ),
            GlobalText(product.price,
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildNonConsumableItem(
      BuildContext context, NonConsumableProduct product, int index) {
    final bool isSelected = nonConsumableIndex == index;
    // This logic might need adjustment based on how proList/proPlusList were intended to be used
    // For now, we assume nonConsumableProductList contains all relevant items,
    // and isProPlus (from parent) + nonConsumableIndex (local selection) determines the active item.

    // Example: Only show items matching current Pro/Pro+ view, or highlight based on that.
    // This depends on whether nonConsumableProductList is pre-filtered or not.
    // If nonConsumableProductList is NOT pre-filtered:
    // bool matchesProPlusState = (isProPlus && product.userCurrentLevel == 2) || (!isProPlus && product.userCurrentLevel == 1);
    // if (!matchesProPlusState) return const SizedBox.shrink(); // Don't build if it doesn't match current tab

    return GestureDetector(
      onTap: () => onChangedNonconsumable(index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withValues(alpha: 0.2)
              : Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
          border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(product.title,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
                GlobalText(product.description,
                    fontSize: 12, color: Colors.black),
                GlobalText(product.planType, fontSize: 14, color: Colors.cyan),
              ],
            ),
            GlobalText(
              product.price,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
