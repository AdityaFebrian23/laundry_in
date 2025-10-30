import 'package:flutter/material.dart';

// Shared pages
import '../views/shared/splash_page.dart';
import '../views/shared/login_page.dart';
import '../views/shared/register_page.dart';

// Role-based views
import '../views/user/home_page.dart';
import '../views/admin_laundry/dashboard_page.dart';
import '../views/petugas/dashboard_page.dart';
import '../views/super_admin/dashboard_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashPage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),

  // Role-based routes
  '/home': (context) => const HomePage(),
  '/admin-laundry': (context) => const AdminLaundryDashboard(),
  '/petugas': (context) => const PetugasDashboard(),
  '/superadmin': (context) => const SuperAdminDashboard(),
};
