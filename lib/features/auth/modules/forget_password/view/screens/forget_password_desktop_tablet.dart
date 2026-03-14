import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/styles/spacing_styles.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/forget_password/view/widgets/forget_password_form.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/forget_password/view/widgets/forget_password_header.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ForgetPasswordScreenDesktopTablet extends StatelessWidget {
  const ForgetPasswordScreenDesktopTablet({super.key});

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
              child: const Column(
                children: [
                  TForgetPasswordHeader(),
                  TForgetPasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
