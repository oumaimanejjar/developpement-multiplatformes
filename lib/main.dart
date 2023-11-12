import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp3/tasks.dart';

import 'firebase_options.dart';
  
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(), //ColorScheme.dark(brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(elevation: 0),
        useMaterial3: true,
      ),
      home: Tasks(),
    ),
  );
}