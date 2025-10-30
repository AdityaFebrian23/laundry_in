import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/laundry_provider.dart';
import '../../models/laundry.dart';
import '../../providers/order_provider.dart';

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
      appBar: AppBar(title: const Text('NYUCIIN - Home')),
      body: ListView.builder(
        itemCount: laundries.length,
        itemBuilder: (c,i){
          final L = laundries[i];
          return ListTile(
            title: Text(L.name),
            subtitle: Text(L.description),
            trailing: Text(L.rating?.toStringAsFixed(1) ?? '-'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LaundryDetailPage(laundry: L))),
          );
        }
      ),
    );
  }
}

class LaundryDetailPage extends StatelessWidget {
  final LaundryModel laundry;
  const LaundryDetailPage({super.key, required this.laundry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(laundry.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text(laundry.description),
          const SizedBox(height: 12),
          const Text('Services:', style: TextStyle(fontWeight: FontWeight.bold)),
          ...laundry.services.map((s) => ListTile(title: Text(s.name), subtitle: Text('${s.price} IDR'))).toList(),
          ElevatedButton(onPressed: () {
            // navigate to order page or build order payload
            Navigator.push(context, MaterialPageRoute(builder: (_) => CreateOrderPage(laundry: laundry)));
          }, child: const Text('Pesan Sekarang'))
        ]),
      ),
    );
  }
}

class CreateOrderPage extends StatefulWidget {
  final LaundryModel laundry;
  const CreateOrderPage({super.key, required this.laundry});
  @override State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  int weight = 1;
  bool loading = false;
  _submit() async {
    setState(() => loading = true);
    final payload = {
      'laundryId': widget.laundry.id,
      'weight_kg': weight,
      'paymentMethod': 'midtrans'
    };
    final ok = await Provider.of<OrderProvider>(context, listen: false).createOrder(payload);
    setState(() => loading = false);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order dibuat')));
      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal membuat order')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Buat Order')), body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Text('Laundry: ${widget.laundry.name}'),
        const SizedBox(height: 8),
        Row(children: [const Text('Berat (kg):'), const Spacer(), IconButton(onPressed: () => setState(()=>weight++), icon: const Icon(Icons.add)), Text('$weight'), IconButton(onPressed: () => setState(()=> weight = weight>1?weight-1:1), icon: const Icon(Icons.remove))]),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: loading?null:_submit, child: loading?const CircularProgressIndicator(color: Colors.white):const Text('Konfirmasi & Bayar'))
      ]),
    ));
  }
}
