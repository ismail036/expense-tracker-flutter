// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _MainPageState();
}

class _MainPageState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false, child: Scaffold(appBar: MyAppBar()));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // gölgeyi kaldırır
      centerTitle: true,
      title: Text(
        "Add new category",
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          // Geri butonu işlevselliği
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
