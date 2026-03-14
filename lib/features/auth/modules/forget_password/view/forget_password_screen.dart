import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/di/service_locator.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';

import 'screens/forget_password_desktop_tablet.dart';
import 'screens/forget_password_mobile.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgetPasswordCubit>(),
      child: const SiteTemplete(
        useLayout: false,
        desktop: ForgetPasswordScreenDesktopTablet(),
        mobile: ForgetPasswordScreenMobile(),
      ),
    );
  }
}
