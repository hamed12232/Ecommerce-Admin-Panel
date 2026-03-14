import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/responsive/site_templete.dart';

import 'screens/reset_password_desktop_tablet.dart';
import 'screens/reset_password_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return SiteTemplete(
      useLayout: false,
      desktop: ResetPasswordScreenDesktopTablet(email: email),
      mobile: ResetPasswordScreenMobile(email: email),
    );
  }
}
