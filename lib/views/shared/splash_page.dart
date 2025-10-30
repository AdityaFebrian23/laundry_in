import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _boot();
  }

  _boot() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.loadFromStorage();
    Timer(const Duration(milliseconds: 800), () {
      if (auth.isAuthenticated) {
        final role = auth.user!.role;
        if (role == 'admin_laundry') {
          Navigator.pushReplacementNamed(context, '/admin-laundry');
        } else if (role == 'petugas') Navigator.pushReplacementNamed(context, '/petugas');
        else if (role == 'superadmin') Navigator.pushReplacementNamed(context, '/superadmin');
        else Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
