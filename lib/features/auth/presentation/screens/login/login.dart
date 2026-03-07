import 'package:flutter/material.dart';

import '../../../../../utils/responsive/site_templete.dart';
import 'responsive_screens/login_desktop_tablet.dart';
import 'responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete(
      useLayout: false,
      desktop: LoginScreenDesktopTablet(),
      mobile: LoginScreenMobile(),
    );
  }
}
