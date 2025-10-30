import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  String? _msg;

  _submit() async {
    setState(() { _loading = true; _msg = null; });
    final res = await AuthService.register({'name': _name.text.trim(), 'email': _email.text.trim(), 'password': _pass.text.trim()});
    setState(() { _loading = false; });
    if (res['ok']) {
      Navigator.pop(context);
    } else {
      setState(() { _msg = res['error']; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Register')),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
        TextField(controller: _pass, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
        const SizedBox(height: 12),
        if (_msg != null) Text(_msg!, style: const TextStyle(color: Colors.red)),
        ElevatedButton(onPressed: _loading ? null : _submit, child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Register'))
      ])),
    );
  }
}
