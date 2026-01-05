import 'package:flutter/material.dart';
import 'package:restaurant_app/services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const RegisterForm({super.key, required this.onSuccess});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(labelText: "Name"),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: emailCtrl,
          decoration: const InputDecoration(labelText: "Email"),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: passCtrl,
          obscureText: true,
          decoration: const InputDecoration(labelText: "Password"),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              AuthService.register(
                nameCtrl.text,
                emailCtrl.text,
                passCtrl.text,
              );
              widget.onSuccess(); // ✅ refresh ProfileWrapper
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text("REGISTER"),
          ),
        ),
      ],
    );
  }
}
