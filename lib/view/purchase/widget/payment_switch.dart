import 'package:flutter/material.dart';

// import '../../../common/global_style.dart'; // Assuming GlobalStyle is not used or will be replaced
import '../../../../component/global_text.dart';

// Payment switch component - used to switch between monthly/annual payment options OR Pro/Pro+
class PaymentSwitch extends StatelessWidget {
  final bool isConsumable; // If true, this switch might be hidden or disabled
  // State control for selecting Pro+ (or annual if that was the original intent)
  final bool isProPlus;
  // Callback function to switch (e.g., between Pro and Pro+)
  final void Function()
      onIsYearChanged; // Renaming might be good if it's not about "year" anymore

  const PaymentSwitch({
    super.key,
    required this.isConsumable,
    required this.isProPlus,
    required this.onIsYearChanged,
  });

  @override
  String toStringShort() {
    return 'PaymentSwitch';
  }

  @override
  Widget build(BuildContext context) {
    // If it's for consumable products, the switch is likely not needed or should be invisible/disabled.
    if (isConsumable) {
      return const SizedBox(
          height:
              35.0); // Maintain height for layout consistency if it's sometimes visible
      // Or return SizedBox.shrink() if it should take no space.
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onIsYearChanged,
      child: AnimatedContainer(
        duration: const Duration(
            milliseconds: 300), // Replace GlobalStyle.animatedDuration
        height: 35.0, // Fixed height when visible
        margin:
            const EdgeInsets.only(bottom: 10.0), // Fixed margin when visible
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: const Color(0xff0A0B12), // Background of the switch track
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Animated "thumb" that slides
            AnimatedPositioned(
              duration: const Duration(
                  milliseconds: 300), // Replace GlobalStyle.animatedDuration
              left: isProPlus ? 60.0 : 0.0, // Position based on isProPlus
              child: Container(
                // The thumb itself
                width: 60.0,
                height: 27.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffF24185), // Active color for the thumb
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            // Row for the "Pro" and "Pro+" labels
            Row(
              mainAxisSize: MainAxisSize.min, // Take only necessary width
              children: [
                _buildSwitchLabel(text: 'Pro', isActive: !isProPlus),
                _buildSwitchLabel(text: 'Pro+', isActive: isProPlus),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchLabel({required String text, required bool isActive}) {
    return Container(
      width: 60.0,
      height: 27.0,
      alignment: Alignment.center,
      // Decoration for the label area (transparent, letting thumb show through or text color change)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(
            milliseconds: 300), // Replace GlobalStyle.animatedDuration
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: GlobalText(
          key: ValueKey<String>(
              text + isActive.toString()), // Unique key for animation
          text,
          color: isActive
              ? Colors.black
              : Colors.grey, // Text color changes based on active state
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
