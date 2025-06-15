import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

// import '../../../common/image_path.dart'; // Assuming ImagePath is not used or will be replaced
import '../../../../component/global_text.dart';
// import '../../../config.dart'; // Assuming Config is not used or will be replaced
// import '../../../generated/l10n.dart'; // Assuming S.current is not used or will be replaced

// Placeholder for Config class - replace with your actual config
class Config {
  static const String subscriptionTermsUrl =
      'https://example.com/subscription_terms';
  static const String privacyPolicyUrl = 'https://example.com/privacy_policy';
  static const String userAgreementUrl = 'https://example.com/user_agreement';
}

// Privacy Policy Component for Payment Page
class PaymentPrivacy extends StatelessWidget {
  const PaymentPrivacy({super.key});

  @override
  String toStringShort() {
    return 'PaymentPrivacy';
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder texts, replace with your actual S.current equivalents
    String securePurchaseText =
        "Secure Purchase via ${kIsWeb ? 'Web' : Platform.isAndroid ? 'Google Play' : Platform.isIOS ? 'App Store' : 'Unknown'}";
    String subscriptionTermsText = "Subscription Terms";
    String privacyPolicyText = "Privacy Policy";
    String termsOfUseText = "Terms of Use";

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          // First row: Display shield icon and security prompt text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security_rounded,
                size: 14,
              ),
              const SizedBox(width: 5),
              GlobalText(
                securePurchaseText,
                fontSize: 12,
              ),
            ],
          ),
          const SizedBox(height: 3.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPolicyLink(
                  context, subscriptionTermsText, Config.subscriptionTermsUrl),
              _buildPolicyLink(
                  context, privacyPolicyText, Config.privacyPolicyUrl),
              _buildPolicyLink(
                  context, termsOfUseText, Config.userAgreementUrl),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyLink(BuildContext context, String text, String url) {
    return Flexible(
      // Added Flexible for better text wrapping and spacing
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 5.0), // Reduced horizontal padding
        child: RichText(
          textAlign: TextAlign.center, // Center align text
          maxLines: 1, // Kept maxLines to 1, consider increasing if needed
          overflow: TextOverflow.ellipsis, // Added overflow handling
          text: TextSpan(
            text: text,
            style: const TextStyle(
              fontFamily:
                  'Urbanist', // Ensure this font is in pubspec.yaml and assets
              color: Color(0xffF24185),
              fontSize: 12.0,
              decoration: TextDecoration
                  .underline, // Added underline for link appearance
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrlString(url);
              },
          ),
        ),
      ),
    );
  }
}
