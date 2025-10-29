import 'package:flutter/material.dart';
import 'views/login_page.dart';

void main() {
  runApp(const LaundryInApp());
}

class LaundryInApp extends StatelessWidget {
  const LaundryInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry.in',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
