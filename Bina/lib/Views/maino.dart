import 'package:flutter/material.dart';

class Maino extends StatefulWidget {
  @override
  _MainoState createState() => _MainoState();
}

class _MainoState extends State<Maino> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            child: Text("Home"),
          ),
          Container(
            child: Text("Search"),
          ),
          Container(
            child: Text("My Basket"),
          ),
          Container(
            child: Text("Saved"),
          ),
          Container(
            child: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
