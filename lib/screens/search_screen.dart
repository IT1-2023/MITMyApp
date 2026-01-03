import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});

  Widget build (BuildContext context){
    return const Scaffold(
      body: Center(
        child: Text(
          "Search Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}