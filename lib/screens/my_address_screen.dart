import 'package:flutter/material.dart';
import '../../models/user_address.dart';
import '../../services/address_service.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController streetCtrl;
  late TextEditingController cityCtrl;
  late TextEditingController zipCtrl;

  @override
  void initState() {
    super.initState();
    final address = AddressService.getAddress();

    nameCtrl = TextEditingController(text: address.fullName);
    phoneCtrl = TextEditingController(text: address.phone);
    streetCtrl = TextEditingController(text: address.street);
    cityCtrl = TextEditingController(text: address.city);
    zipCtrl = TextEditingController(text: address.zip);
  }

  void _saveAddress() {
    AddressService.updateAddress(
      UserAddress(
        fullName: nameCtrl.text,
        phone: phoneCtrl.text,
        street: streetCtrl.text,
        city: cityCtrl.text,
        zip: zipCtrl.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Address updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Address"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(nameCtrl, "Full Name"),
            _input(phoneCtrl, "Phone"),
            _input(streetCtrl, "Street"),
            _input(cityCtrl, "City"),
            _input(zipCtrl, "ZIP Code"),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController ctrl, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
