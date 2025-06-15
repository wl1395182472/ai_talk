import 'dart:io';

import 'package:ai_talk/constant/image_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart'; // Assuming Get is not used or will be replaced

// import '../../../common/global_style.dart'; // Assuming GlobalStyle is not used or will be replaced
// import '../../../common/image_path.dart'; // Assuming ImagePath is not used or will be replaced
import '../../../../component/global_text.dart';
// import '../../../generated/l10n.dart'; // Assuming S.current is not used or will be replaced
// import '../../../tools/http_util.dart'; // Assuming HttpUtil is not used or will be replaced
// import '../../../tools/navigator_util.dart'; // Assuming NavigatorUtil is not used or will be replaced

// Payment Page Top AppBar Component
class PaymentAppBar extends StatelessWidget {
  // Indicates if the product is consumable
  final bool isConsumable;
  // Index for consumable products
  final int consumableIndex;
  // Index for non-consumable products
  final int nonConsumableIndex;
  final bool isProPlus;
  // Callback for restore purchase button click
  final void Function() onClickRestore;

  const PaymentAppBar({
    super.key,
    required this.isConsumable,
    required this.consumableIndex,
    required this.nonConsumableIndex,
    required this.isProPlus,
    required this.onClickRestore,
  });

  @override
  String toStringShort() {
    return 'PaymentAppBar';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      // Set top margin to accommodate status bar
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          // Left side back button
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  // NavigatorUtil.navigateBack(); // Replace with Navigator.pop(context) or GoRouter equivalent
                  Navigator.of(context).pop();
                },
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xff933CF3),
                      Color(0xffEE3CD4),
                      Color(0xffFB6D88),
                      Color(0xffF5DD87),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Image.asset(
                    '${ImagePath.instance.global}back.png',
                    width: 81.h,
                    height: 81.h,
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              // child: Obx( // Replace with equivalent logic if GetX is not used
              //   () =>
              child: AnimatedSwitcher(
                duration: const Duration(
                    milliseconds: 300), // Replace GlobalStyle.animatedDuration
                // child: HttpUtil.isReview && !kIsWeb && Platform.isIOS // Replace with your review mode logic
                child: !kIsWeb && Platform.isIOS // Simplified condition
                    ? ElevatedButton(
                        onPressed: onClickRestore,
                        child: const GlobalText('Restore'),
                      )
                    : const SizedBox(),
              ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
