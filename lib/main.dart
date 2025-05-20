import 'package:bazaro_cs/firebase_options.dart';
import 'package:bazaro_cs/my_app.dart';
import 'package:bazaro_cs/src/core/constants/supabase_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: SupabaseKeys.url,
    anonKey: SupabaseKeys.anonKey,
  );
  runApp(const MyApp());
}
