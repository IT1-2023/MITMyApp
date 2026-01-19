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
  final confirmPassCtrl = TextEditingController();

  String? errorMessage;

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return passwordRegex.hasMatch(password);
  }

  void _showError(String message) {
    setState(() {
      errorMessage = message;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // NAME
        TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(labelText: "Name"),
        ),
        const SizedBox(height: 12),

        // EMAIL
        TextField(
          controller: emailCtrl,
          decoration: const InputDecoration(labelText: "Email"),
        ),
        const SizedBox(height: 12),

        // PASSWORD
        TextField(
          controller: passCtrl,
          obscureText: true,
          decoration: const InputDecoration(labelText: "Password"),
        ),
        const SizedBox(height: 6),
        Text(
          "Password must have at least 6 characters,\n"
          "including one letter and one number",
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),

        // CONFIRM PASSWORD
        TextField(
          controller: confirmPassCtrl,
          obscureText: true,
          decoration:
              const InputDecoration(labelText: "Confirm Password"),
        ),

        // ERROR TEXT (ispod polja)
        if (errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        ],

        const SizedBox(height: 24),

        // REGISTER BUTTON
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final name = nameCtrl.text.trim();
              final email = emailCtrl.text.trim();
              final password = passCtrl.text;
              final confirmPassword = confirmPassCtrl.text;

              setState(() => errorMessage = null);

              if (name.isEmpty ||
                  email.isEmpty ||
                  password.isEmpty ||
                  confirmPassword.isEmpty) {
                _showError("All fields are required");
                return;
              }

              if (!_isValidEmail(email)) {
                _showError("Invalid email format");
                return;
              }

              if (!_isValidPassword(password)) {
                _showError(
                  "Password must contain at least 6 characters,\n"
                  "one letter and one number",
                );
                return;
              }

              if (password != confirmPassword) {
                _showError("Passwords do not match");
                return;
              }

              AuthService.register(name, email, password);
              _showSuccess("Registration successful!");
              widget.onSuccess();
              Navigator.pop(context);
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text("REGISTER"),
          ),
        ),
      ],
    );
  }
}
