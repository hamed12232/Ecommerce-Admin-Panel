import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yt_ecommerce_admin_panel/firebase_options.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/auth_guard.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/di/service_locator.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/local_storage/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  await SharedPrefServices.init();
  setPathUrlStrategy();
  runApp(const AuthGuard());
}
