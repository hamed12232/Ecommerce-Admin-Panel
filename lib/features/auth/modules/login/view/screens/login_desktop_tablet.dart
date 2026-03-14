import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/styles/spacing_styles.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/login/view/widgets/login_form.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/login/view/widgets/login_header.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

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
                  TLoginHeader(),
                  TLoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
