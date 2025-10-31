import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart';
import '../../config/constants.dart';
import '../../providers/auth_provider.dart';

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({super.key});

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {
  List<dynamic> laundries = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadLaundries();
  }

  Future<void> _loadLaundries() async {
    setState(() => loading = true);
    final res = await ApiService.get(API.LAUNDRIES);
    if (res.statusCode == 200) {
      setState(() => laundries = jsonDecode(res.body) as List);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal memuat data')));
    }
    setState(() => loading = false);
  }

  Future<void> _verify(String id, bool verify) async {
    final res =
        await ApiService.post('${API.ADMIN}/laundry/$id/verify', {'verify': verify});
    if (!mounted) return;
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Status verifikasi diperbarui')));
      _loadLaundries();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal memperbarui status')));
    }
  }

  Future<void> _deleteLaundry(String id) async {
    final res = await ApiService.delete('${API.LAUNDRIES}/$id');
    if (!mounted) return;
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Laundry dihapus')));
      _loadLaundries();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal menghapus laundry')));
    }
  }

  void _showLaundryForm({Map<String, dynamic>? existing}) {
    final nameCtrl = TextEditingController(text: existing?['name'] ?? '');
    final streetCtrl =
        TextEditingController(text: existing?['address']?['street'] ?? '');
    final cityCtrl =
        TextEditingController(text: existing?['address']?['city'] ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? 'Tambah Laundry' : 'Edit Laundry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Nama Laundry')),
              TextField(
                  controller: streetCtrl,
                  decoration: const InputDecoration(labelText: 'Alamat Jalan')),
              TextField(
                  controller: cityCtrl,
                  decoration: const InputDecoration(labelText: 'Kota')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              final payload = {
                'name': nameCtrl.text,
                'address': {
                  'street': streetCtrl.text,
                  'city': cityCtrl.text,
                },
              };

              if (existing == null) {
                // CREATE
                final res = await ApiService.post(API.LAUNDRIES, payload);
                if (!mounted) return;
                if (res.statusCode == 201) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Laundry ditambahkan')));
                  _loadLaundries();
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Gagal menambah laundry')));
                }
              } else {
                // UPDATE
                final res =
                    await ApiService.put('${API.LAUNDRIES}/${existing['_id']}', payload);
                if (!mounted) return;
                if (res.statusCode == 200) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Laundry diperbarui')));
                  _loadLaundries();
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Gagal memperbarui')));
                }
              }

              if (!mounted) return;
              Navigator.pop(context);
            },
            child: Text(existing == null ? 'Tambah' : 'Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Super Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business),
            onPressed: () => _showLaundryForm(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () =>
                Provider.of<AuthProvider>(context, listen: false).logout(context),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : laundries.isEmpty
              ? const Center(child: Text('Tidak ada data laundry'))
              : ListView.builder(
                  itemCount: laundries.length,
                  itemBuilder: (c, i) {
                    final p = laundries[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(p['name'] ?? ''),
                        subtitle: Text(p['address']?['street'] ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.check, color: Colors.green),
                                onPressed: () => _verify(p['_id'], true)),
                            IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showLaundryForm(existing: p)),
                            IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteLaundry(p['_id'])),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
