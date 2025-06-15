import 'package:flutter/material.dart';

import '../../../../component/global_text.dart';

// Payment Description Component
// Used to display detailed information for consumable and non-consumable products
class PaymentDescription extends StatelessWidget {
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

  const PaymentDescription({
    super.key,
    required this.isLoadingProducts,
    required this.isConsumable,
    required this.consumableIndex,
    required this.nonConsumableIndex,
    required this.isProPlus,
    required this.onClickChangeIsConsumable,
  });

  @override
  String toStringShort() {
    return 'PaymentDescription';
  }

  final double iconSize = 20.0; // Renamed from size for clarity

  @override
  Widget build(BuildContext context) {
    String titleText = isConsumable
        ? "Token Pack ${consumableIndex + 1}"
        : (isProPlus ? "Pro+ Plan" : "Pro Plan");
    List<String> benefits = isConsumable
        ? [
            "Benefit A for Tokens",
            "Benefit B for Tokens",
            "Benefit C for Tokens"
          ]
        : (isProPlus
            ? [
                "Unlock All Pro+ Features",
                "Exclusive Content",
                "Priority Support"
              ]
            : ["Unlock All Pro Features", "Standard Content", "Email Support"]);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Left Arrow (to select consumable if not already)
          AnimatedSwitcher(
            duration: const Duration(
                milliseconds: 300), // Replace GlobalStyle.animatedDuration
            child: isLoadingProducts
                ? Container(
                    key: ValueKey(isLoadingProducts),
                    width: iconSize + 10.0, // Adjusted width for padding
                    height: iconSize + 10.0, // Adjusted height for padding
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 5.0,
                    ),
                  )
                : InkWell(
                    key: ValueKey('left_arrow_${!isLoadingProducts}'),
                    onTap: () => onClickChangeIsConsumable(true),
                    child: Container(
                      width: iconSize + 10.0, // Adjusted width for padding
                      height: iconSize + 10.0, // Adjusted height for padding
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 5.0,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: isConsumable ? Colors.grey[700] : Colors.black,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
          ),
          Expanded(
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      key: ValueKey(
                          '$isConsumable-$isProPlus-$consumableIndex-$nonConsumableIndex'), // More specific key
                      children: [
                        GlobalText(titleText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        const SizedBox(height: 10),
                        ...benefits.map(
                          (benefit) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_box,
                                size: iconSize * 0.8,
                                color: Colors.greenAccent,
                              ),
                              const SizedBox(width: 8),
                              GlobalText(
                                benefit,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoadingProducts
                ? Container(
                    key: ValueKey('right_arrow_loading_$isLoadingProducts'),
                    width: iconSize + 10.0,
                    height: iconSize + 10.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 5.0,
                    ),
                  )
                : InkWell(
                    key: ValueKey(
                        'right_arrow_${!isLoadingProducts}'), // Unique key
                    onTap: () => onClickChangeIsConsumable(false),
                    child: Container(
                      width: iconSize + 10.0,
                      height: iconSize + 10.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 5.0,
                      ),
                      padding: const EdgeInsets.all(
                          5.0), // Added padding around icon
                      child: FittedBox(
                        fit: BoxFit.contain, // Changed to contain
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color:
                              !isConsumable ? Colors.grey[700] : Colors.black,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
