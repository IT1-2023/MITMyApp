import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/home_screen.dart';import 'package:restaurant_app/screens/cart_screen.dart';
import 'package:restaurant_app/screens/profile_screen.dart';
import 'package:restaurant_app/screens/search_screen.dart';

class RootScreen extends StatefulWidget{
    const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State <RootScreen>{
  int _currentIndex=0;

  final screens= [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
  title: const Text("RESTAURANT APP"),
),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex,
      onTap: (index){
        setState(() =>_currentIndex=index);
      },
      items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label:"Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label :"Profile"),
      ],
    ),
    );
  }
}