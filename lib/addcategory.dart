// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter the name of category"),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(hintText: "..."),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Select the icon category"),
                  Row(
                    children: [Image.asset("assets/icons/clothes.png")],
                  ),
                  Row(),
                ],
              ),
            )
          ],
        ),
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
