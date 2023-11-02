import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Custom background color
      padding: EdgeInsets.only(top: 24.0), // Add padding to the top for status bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Add menu button functionality
            },
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search button functionality
            },
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(56); // Set the desired app bar height
}
class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar2({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Custom background color
      padding: EdgeInsets.only(top: 24.0), // Add padding to the top for status bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {
              // Add search button functionality
            },
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {
              // Add search button functionality
            },
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(56); // Set the desired app bar height
}

