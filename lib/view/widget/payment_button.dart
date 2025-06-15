import 'package:flutter/material.dart';

// import '../../../common/global_style.dart'; // Assuming GlobalStyle is not used or will be replaced
import '../../../../component/global_button.dart';
// import '../../../generated/l10n.dart'; // Assuming S.current is not used or will be replaced

// Payment Button Component
class PaymentButton extends StatelessWidget {
  // Indicates if the product is consumable
  final bool isConsumable;
  // Indicates if products are loading
  final bool isLoadingProducts;
  // Callback for purchase button click
  final void Function() onClickPurchase;

  const PaymentButton({
    super.key,
    required this.isConsumable,
    required this.isLoadingProducts,
    required this.onClickPurchase,
  });

  @override
  String toStringShort() {
    return 'PaymentButton';
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingProducts
        ? const SizedBox(
            height: 48.0) // Maintain height during loading for layout stability
        : Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 5.0), // Added vertical padding
            child: Row(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(
                        milliseconds:
                            300), // Replace GlobalStyle.animatedDuration
                    child: isLoadingProducts
                        // Display empty placeholder during loading
                        ? SizedBox(
                            key: ValueKey(
                                isLoadingProducts), // Ensure unique key for AnimatedSwitcher
                            height: 48.0, // Match button height
                          )
                        // Display purchase button when not loading
                        : GlobalButton(
                            key: ValueKey(
                                !isLoadingProducts), // Ensure unique key for AnimatedSwitcher
                            onPressed:
                                onClickPurchase, // Changed from handlePressed
                            height: 48.0, // Changed from buttonHeight
                            text: 'Pay', // Replace S.current.pay
                          ),
                  ),
                ),
              ],
            ),
          );
  }
}
