import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atividade de Nevagação',
      theme: ThemeData(
        primarySwatch: CustomTheme.black,
        scaffoldBackgroundColor: Colors.grey.shade200,
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: CustomTheme.elevatedButtonStyle),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: CustomTheme.black),
      ),
      home: const LoginPage(),
    );
  }
}
