// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, constant_identifier_names, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilive/categorywidget.dart';

const int DF_CLR = 0XFF07873A;
const double SPC_BTW = 15.0;
String expenseValue = '';
String expenseamountValue = '';

Map<String, String> categoryMap = {
  "Choose a icon": "Select a icon",
  "assets/icons/car.png": "Car",
  "assets/icons/clothes.png": "Clothes",
  "assets/icons/shop.png": "Shop",
  "assets/icons/eat.png": "Eat",
  "assets/icons/gifts.png": "Gifts",
  "assets/icons/education10x.png": "Education",
  "assets/icons/insurance.png": "Insurance",
  "assets/icons/childrensproducts.png": "Childrens Products",
  "assets/icons/taxes.png": "Taxes",
  "assets/icons/utilities.png": "Utilities",
  "assets/icons/recreationandentertainment.png": "Recreation and Entertainment",
  "assets/icons/housing.png": "Housing",
  "assets/icons/petsupplies.png": "Pet Supplies",
  "assets/icons/medicine.png": "Medicine",
};

class AddExpenes extends StatefulWidget {
  const AddExpenes({super.key});

  @override
  State<AddExpenes> createState() => _MainPageState();
}

class _MainPageState extends State<AddExpenes> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(child: MyBody()),
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
      elevation: 0,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Add expenses",
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
  String? selectedImage;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enter the name of the expense",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextField(
                      decoration: InputDecoration(hintText: "..."),
                      onChanged: (value) {
                        setState(() {
                          expenseValue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Select an expense category",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  CategorySelectorWidget(
                    onImageSelected: (imagePath) {
                      setState(() {
                        selectedImage = imagePath;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Enter the amount of expense",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width - 300,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "\$",
                            suffixText: "\$",
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              expenseamountValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(DF_CLR), // Düğme metni rengi
                side: BorderSide(color: Colors.white, width: 2), // Kenarlık
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
                foregroundColor: Color(DF_CLR),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Kenar yuvarlaklığı
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Düğme metni rengi
                side: BorderSide(color: Color(DF_CLR), width: 2), // Kenarlık
                minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
                foregroundColor: Color(DF_CLR),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Kenar yuvarlaklığı
                ),
              ),
              onPressed: () {
                print(
                    "Name : $expenseValue Value : $expenseamountValue Choose : ${categoryMap[selectedImage]}");
              },
              child: Text(
                'Save',
                style: TextStyle(color: Color(DF_CLR)),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
