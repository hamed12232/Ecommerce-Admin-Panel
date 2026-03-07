import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/firebase_options.dart';

import 'app.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const App());
}
