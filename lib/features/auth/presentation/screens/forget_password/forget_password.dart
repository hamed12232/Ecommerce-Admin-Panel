import 'package:flutter/material.dart';

import '../../../../../utils/responsive/site_templete.dart';
import 'responsive_screens/forget_password_desktop_tablet.dart';
import 'responsive_screens/forget_password_mobile.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete(
      useLayout: false,
      desktop: ForgetPasswordScreenDesktopTablet(),
      mobile: ForgetPasswordScreenMobile(),
    );
  }
}
