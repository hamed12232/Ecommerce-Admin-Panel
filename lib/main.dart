import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:yt_ecommerce_admin_panel/firebase_options.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/auth_guard.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/di/service_locator.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/local_storage/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://icbtdurswywzkffoxzqs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImljYnRkdXJzd3l3emtmZm94enFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYyMTgyNjUsImV4cCI6MjA4MTc5NDI2NX0.XHUamSqRV2FRVxsVXR-UD47AUZJ6pAys_MNbDdfxKvs',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  await SharedPrefServices.init();
  setPathUrlStrategy();
  runApp(const AuthGuard());
}
