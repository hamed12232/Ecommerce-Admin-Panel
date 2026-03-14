import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/login/view/widgets/login_form.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/login/view/widgets/login_header.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TLoginHeader(),
              TLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
