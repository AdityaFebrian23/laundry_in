import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../config/constants.dart';
import 'dart:convert';

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({super.key});

  @override State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {
  List<dynamic> pending = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadPending();
  }

  _loadPending() async {
    final res = await ApiService.get(API.LAUNDRIES, query: {'isVerified': 'false'});
    if (res.statusCode == 200) {
      setState(() => pending = jsonDecode(res.body) as List);
    }
    setState(() => loading = false);
  }

  _verify(String id, bool verify) async {
    final res = await ApiService.post('${API.ADMIN}/laundry/$id/verify', {'verify': verify});
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated')));
      _loadPending();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Super Admin')), body: loading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
      itemCount: pending.length,
      itemBuilder: (c,i){
        final p = pending[i];
        return ListTile(
          title: Text(p['name'] ?? ''),
          subtitle: Text(p['address']?['street'] ?? ''),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => _verify(p['_id'], true)),
            IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () => _verify(p['_id'], false))
          ]),
        );
      },
    ));
  }
}
