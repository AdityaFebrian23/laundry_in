import 'package:flutter/material.dart';
import '../views/shared/splash_page.dart';
import '../views/shared/login_page.dart';
import '../views/shared/register_page.dart';
import '../views/user/home_page.dart';
import '../views/admin_laundry/dashboard_page.dart';
import '../views/petugas/dashboard_page.dart';
import '../views/super_admin/dashboard_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (c) => const SplashPage(),
  '/login': (c) => const LoginPage(),
  '/register': (c) => const RegisterPage(),
  '/home': (c) => const HomePage(),
  '/admin-laundry': (c) => const AdminLaundryDashboard(),
  '/petugas': (c) => const PetugasDashboard(),
  '/superadmin': (c) => const SuperAdminDashboard(),
};
