import 'package:flutter/material.dart';

class DashboardUser extends StatelessWidget {
  const DashboardUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Pengguna")),
      body: const Center(child: Text("Halo User, pilih layanan laundry terbaik.")),
    );
  }
}
