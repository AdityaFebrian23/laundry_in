import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/location_helper.dart';

class PetugasDashboard extends StatefulWidget {
  const PetugasDashboard({super.key});

  @override State<PetugasDashboard> createState() => _PetugasDashboardState();
}

class _PetugasDashboardState extends State<PetugasDashboard> {
  IO.Socket? socket;
  bool connected = false;

  @override
  void initState() {
    super.initState();
    _initSocket();
  }

  void _initSocket() {
    final base = Uri.parse('http://10.0.2.2:4000'); // sync with constants, or use API.SOCKET_IO
    socket = IO.io(base.toString(), <String, dynamic>{'transports': ['websocket']});
    socket!.on('connect', (_) => setState(()=>connected=true));
    socket!.on('disconnect', (_) => setState(()=>connected=false));
  }

  _sendLocation() async {
    final pos = await LocationHelper.currentPosition();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (pos != null && socket != null && socket!.connected) {
      socket!.emit('location:update', {
        'petugasId': auth.user?.id,
        'lat': pos.latitude,
        'lng': pos.longitude,
        'orderId': null,
        'userId': null
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lokasi terkirim')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Petugas Dashboard')), body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text('Socket: ${connected? "connected":"disconnected"}'),
      const SizedBox(height: 12),
      ElevatedButton(onPressed: _sendLocation, child: const Text('Kirim Lokasi Sekarang'))
    ])));
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }
}
