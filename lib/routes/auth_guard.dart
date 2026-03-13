import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/auth_service.dart';
import 'package:yt_ecommerce_admin_panel/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/device/web_material_scroll.dart';
import 'package:yt_ecommerce_admin_panel/utils/theme/theme.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        final bool isAuthenticated = snapshot.hasData;
        // ── 4. Render the App ──
        // We use ValueKey(isAuthenticated) to ensure the entire tree/Navigator
        // is reset when the user logs in or out.
        return MaterialApp(
          key: ValueKey(isAuthenticated),
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          initialRoute: isAuthenticated
              ? AppRoutes.appInitialRoute
              : AppRoutes.authInitialRoute,
          onGenerateRoute: isAuthenticated
              ? AppRoutes.onGenerateAppRoute
              : AppRoutes.onGenerateAuthRoute,
        );
      },
    );
  }
}
