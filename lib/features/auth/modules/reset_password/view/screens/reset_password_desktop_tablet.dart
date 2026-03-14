import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/styles/spacing_styles.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/text_strings.dart';

class ResetPasswordScreenDesktopTablet extends StatelessWidget {
  const ResetPasswordScreenDesktopTablet({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 550,
          child: SingleChildScrollView(
            child: Container(
              padding: TSpacingStyle.paddingWithAppBarHeight,
              decoration: BoxDecoration(
                color: TColors.white,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const Image(width: 300, height: 200, image: AssetImage(TImages.deliveredEmailIllustration)),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(email, style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(TTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                      child: const Text(TTexts.done),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TextButton(onPressed: () {}, child: const Text(TTexts.resendEmail)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
