import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ? const SizedBox(height: 48.0)
        : Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isLoadingProducts
                        ? SizedBox(
                            key: ValueKey(isLoadingProducts),
                            height: 144.h,
                          )
                        : Container(
                            key: ValueKey(!isLoadingProducts),
                            height: 144.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(78.r),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffFA63CA),
                                  Color(0xffFF7271),
                                ],
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: onClickPurchase,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor:
                                    Colors.black.withValues(alpha: 0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(78.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Pay',
                                    style: TextStyle(
                                      fontSize: 69.sp,
                                      height: 1.0,
                                      letterSpacing: 0.58,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
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
