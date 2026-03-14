import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/login/controller/cubit/login_cubit.dart';
import 'package:yt_ecommerce_admin_panel/utils/di/service_locator.dart';
import 'package:yt_ecommerce_admin_panel/utils/responsive/site_templete.dart';

import 'screens/login_desktop_tablet.dart';
import 'screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const SiteTemplete(
        useLayout: false,
        desktop: LoginScreenDesktopTablet(),
        mobile: LoginScreenMobile(),
      ),
    );
  }
}
