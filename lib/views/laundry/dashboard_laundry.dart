import 'package:flutter/material.dart';

class DashboardLaundry extends StatelessWidget {
  const DashboardLaundry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Laundry")),
      body: const Center(child: Text("Halo Laundry Owner, kelola pesanan di sini.")),
    );
  }
}
