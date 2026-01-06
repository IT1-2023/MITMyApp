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
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // avatar icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 64,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 24),
              //title 
               const Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              //subtitle 
              const Text(
                "Login or create an account to manage\norders and your profile.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 32),

              //login/register
                SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => showAuthModal(context, (){
                    setState(() {}
                    );
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Login / Register",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
