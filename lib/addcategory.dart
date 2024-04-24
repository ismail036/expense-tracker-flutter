// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

const int DF_CLR = 0XFF07873A;

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _MainPageState();
}

class _MainPageState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: MyAppBar(),
          body: MyBody(),
        ));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

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
        icon: Icon(Icons.arrow_back_ios_new, color: Color(DF_CLR)),
        onPressed: () {
          // Geri butonu işlevselliği
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class MyBody extends StatefulWidget {
  const MyBody({super.key});

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(),
        Row(children: [
          Text("Name of the category"),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
            onPressed: () {
              // İlk butona tıklandığında yapılacak işlemler
            },
            child: Text('Buton 1'),
          ),
          ElevatedButton(
            onPressed: () {
              // İkinci butona tıklandığında yapılacak işlemler
            },
            child: Text('Buton 2'),
          ),
        ]),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Altı Çizili Metin',
        labelStyle: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
