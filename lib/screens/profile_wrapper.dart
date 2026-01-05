import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/auth/auth_modal.dart';
import 'package:restaurant_app/screens/profile_screen.dart';
import 'package:restaurant_app/services/auth_service.dart';

class ProfileWrapper extends StatefulWidget {
  const ProfileWrapper({super.key});

  @override
  State<ProfileWrapper> createState() => _ProfileWrapperState();
}

class _ProfileWrapperState extends State<ProfileWrapper> {
  @override
  Widget build(BuildContext context) {
    if (!AuthService.isLoggedIn()) {
      return Center(
        child: ElevatedButton(
          onPressed: () => showAuthModal(
            context,
            () => setState(() {}),
          ),
          child: const Text("Login / Register"),
        ),
      );
    }

    return ProfileScreen(
      onLogout: () {
        setState(() {}); // refresh nakon logout-a
      },
    );
  }
}
