import 'package:flutter/material.dart';

import '../../../../../utils/responsive/site_templete.dart';
import 'responsive_screens/reset_password_desktop_tablet.dart';
import 'responsive_screens/reset_password_mobile.dart';

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
