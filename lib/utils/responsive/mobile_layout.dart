import 'package:flutter/material.dart';

import '../../common/widgets/layouts/headers/header.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});
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
