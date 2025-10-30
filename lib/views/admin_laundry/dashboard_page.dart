import 'package:flutter/material.dart';

class AdminLaundryDashboard extends StatelessWidget {
  const AdminLaundryDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Admin Laundry Dashboard')), body: const Center(child: Text('Fitur admin laundry: manage services, orders, staff')));
  }
}
