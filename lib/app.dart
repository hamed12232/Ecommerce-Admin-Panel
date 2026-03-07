import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/utils/responsive/site_templete.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: const ResposiveDesign(),
    );
  }
  
}
class ResposiveDesign extends StatelessWidget {
  const ResposiveDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete();
  }
}
