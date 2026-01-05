import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/auth/login_form.dart';
import 'package:restaurant_app/screens/auth/register_form.dart';

void showAuthModal(BuildContext context, VoidCallback onSuccess) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AuthModal(onSuccess: onSuccess),
  );
}

class AuthModal extends StatefulWidget {
  final VoidCallback onSuccess;

  const AuthModal({super.key, required this.onSuccess});

  @override
  State<AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<AuthModal> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tab("Login", isLogin, () => setState(() => isLogin = true)),
              _tab("Register", !isLogin, () => setState(() => isLogin = false)),
            ],
          ),

          const SizedBox(height: 24),

          Expanded(
            child: isLogin
                ? LoginForm(onSuccess: widget.onSuccess)
                : RegisterForm(onSuccess: widget.onSuccess),
          ),
        ],
      ),
    );
  }

  Widget _tab(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? Colors.orange : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.orange : Colors.grey,
          ),
        ),
      ),
    );
  }
}
