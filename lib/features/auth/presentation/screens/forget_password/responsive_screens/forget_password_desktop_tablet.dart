import 'package:flutter/material.dart';

import '../../../../../../common/styles/spacing_styles.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/forget_password_form.dart';
import '../widgets/forget_password_header.dart';

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
                  // Header
                  TForgetPasswordHeader(),

                  // Form
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
