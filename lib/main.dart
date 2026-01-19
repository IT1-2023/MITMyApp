import 'package:flutter/material.dart';
import 'package:restaurant_app/models/cart_model.dart';
import 'package:restaurant_app/models/wishlist_model.dart';
import 'package:restaurant_app/screens/root_screen.dart';
import 'package:provider/provider.dart';

void main() {
runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => WishlistModel()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(useMaterial3: false),
     home: RootScreen(),
    );
  }
}

