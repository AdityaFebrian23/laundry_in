import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/laundry_provider.dart';
import '../../views/user/laundry_detail_page.dart';
import '../../providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool init = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!init) {
      Provider.of<LaundryProvider>(context, listen: false).fetchLaundries();
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
  final laundries = Provider.of<LaundryProvider>(context).laundries;
    return Scaffold(
      appBar: AppBar(
        title: const Text('NYUCIIN - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(context),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: laundries.length,
        itemBuilder: (c, i) {
          final laundry = laundries[i];
          return ListTile(
            title: Text(laundry.name),
            subtitle: Text(laundry.description),
            trailing: Text(laundry.rating?.toStringAsFixed(1) ?? '-'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LaundryDetailPage(laundry: laundry)),
            ),
          );
        },
      ),
    );
  }
}