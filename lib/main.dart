import 'package:flutter/material.dart';
import 'package:restaurant_app/models/cart_model.dart';
import 'package:restaurant_app/screens/root_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create:(_) => CartModel(),
    child:
    const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(useMaterial3: false),
     home: RootScreen(),
    );
  }
}

