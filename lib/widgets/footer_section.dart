import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "RestaurantApp",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Quality food delivered to your door.",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),

               Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _FooterColumn(
                  title: "Company",
                  items: [
                    "Home",
                    "About us",
                    "Delivery",
                    "Privacy policy",
                  ],
                ),
              ),
              Expanded(
                child: _FooterColumn(
                  title: "Contact",
                  items: [
                    "+381 64 123 456",
                    "contact@restaurantapp.com",
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

           const Divider(color: Colors.white24),

          const SizedBox(height: 12),

          // COPYRIGHT
          Center(
            child: Text(
              "© 2026 RestaurantApp. All rights reserved.",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(item, style: const TextStyle(color: Colors.white70)),
          ),
        ),
      ],
    );
  }
}
