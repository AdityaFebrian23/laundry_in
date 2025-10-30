import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  String? _error;

  void _submit() async {
    setState(() { _loading = true; _error = null; });
    final res = await AuthService.login(_email.text.trim(), _pass.text.trim());
    setState(() { _loading = false; });
    if (res['ok']) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      await auth.setUserFromMap(res['user']);
      final role = res['user']['role'];
      if (role == 'admin_laundry') {
        Navigator.pushReplacementNamed(context, '/admin-laundry');
      } else if (role == 'petugas') Navigator.pushReplacementNamed(context, '/petugas');
      else if (role == 'superadmin') Navigator.pushReplacementNamed(context, '/superadmin');
      else Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() { _error = res['error'] ?? 'Login failed'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _pass, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 12),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(onPressed: _loading ? null : _submit, child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login')),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: const Text('Register'))
          ],
        ),
      ),
    );
  }
}
