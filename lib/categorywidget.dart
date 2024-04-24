// ignore_for_file: library_private_types_in_public_api, use_super_parameters, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:unilive/addexpenses.dart';

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

class CategorySelectorWidget extends StatefulWidget {
  final ValueChanged<String>? onImageSelected;

  CategorySelectorWidget({Key? key, this.onImageSelected}) : super(key: key);

  @override
  _CategorySelectorWidgetState createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {
  String? selectedImage;
  List<String> imagePaths = [
    "assets/icons/clothes.png",
    "assets/icons/shop.png",
    "assets/icons/eat.png",
    "assets/icons/gifts.png",
    "assets/icons/education10x.png",
    "assets/icons/insurance.png",
    "assets/icons/childrensproducts.png",
    "assets/icons/taxes.png",
    "assets/icons/recreationandentertainment.png",
    "assets/icons/utilities.png",
    "assets/icons/housing.png",
    "assets/icons/car.png",
    "assets/icons/medicine.png",
    "assets/icons/petsupplies.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: imagePaths.map((path) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedImage = path;
            });
            if (widget.onImageSelected != null) {
              widget.onImageSelected!(path);
            }
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30, // İkon genişliği
                        height: 30, // İkon yüksekliği
                        decoration: BoxDecoration(
                          color: selectedImage == path ? Color(DF_CLR) : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          path,
                          color: selectedImage == path ? Colors.white : null,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        categoryMap[path]!,
                        style: TextStyle(
                            fontSize: 16,
                            color: selectedImage == path ? Color(DF_CLR) : null,
                            fontWeight:
                                selectedImage == path ? FontWeight.bold : null),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 2,
                color: Colors.black,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
