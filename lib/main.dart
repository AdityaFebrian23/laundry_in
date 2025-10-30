import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/laundry_provider.dart';
import 'providers/order_provider.dart';
import 'routes/app_routes.dart';
import 'views/shared/splash_page.dart';

void main() {
  runApp(const NyuciinApp());
}

class NyuciinApp extends StatelessWidget {
  const NyuciinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LaundryProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'NYUCIIN',
        theme: appTheme,
        initialRoute: '/',
        routes: appRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
