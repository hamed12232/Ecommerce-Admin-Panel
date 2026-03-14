import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/forget_password/view/widgets/forget_password_form.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/forget_password/view/widgets/forget_password_header.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class ForgetPasswordScreenMobile extends StatelessWidget {
  const ForgetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TForgetPasswordHeader(),
              TForgetPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
