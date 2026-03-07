import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/headers/header.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});
  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(),
      appBar: THeader(scaffoldKey: scaffoldKey),
      body: body ?? const SizedBox(),
    );
  }
}
