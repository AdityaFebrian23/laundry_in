import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class AdminLaundryDashboard extends StatelessWidget {
  const AdminLaundryDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Laundry Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(context),
          )
        ],
      ),
      body: const Center(
        child: Text('Fitur admin laundry: manage services, orders, staff'),
    ),
    );
  }
}