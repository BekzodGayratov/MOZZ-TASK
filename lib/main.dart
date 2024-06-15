import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mozz_task/firebase_options.dart';
import 'package:mozz_task/layers/presentation/app_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const AppRoot());
}
