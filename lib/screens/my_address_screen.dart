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

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    streetCtrl = TextEditingController();
    cityCtrl = TextEditingController();
    zipCtrl = TextEditingController();

    _loadAddress();
  }

  Future<void> _loadAddress() async {
    try {
      final address = await AddressService.getAddress();
      if (address != null) {
        nameCtrl.text = address.fullName;
        phoneCtrl.text = address.phone;
        streetCtrl.text = address.street;
        cityCtrl.text = address.city;
        zipCtrl.text = address.zip;
      }
    } catch (_) {
      // ignore load errors; UI will still be editable
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _saveAddress() async {
    await AddressService.updateAddress(
      UserAddress(
        fullName: nameCtrl.text,
        phone: phoneCtrl.text,
        street: streetCtrl.text,
        city: cityCtrl.text,
        zip: zipCtrl.text,
      ),
    );

    if (!mounted) return;
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
