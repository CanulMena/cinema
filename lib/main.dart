import 'package:cinema/presentation/screens/movies/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinema/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {

  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: MainApp()
      )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: HomeScreen()
      ),
    );
  }
}