import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';

import 'expense.dart';
import 'home.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff07873A),
    ));
    return Scaffold(
      body: CategoryBody(),
    );
  }
}

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  List<Expense> expenseList = [];

  Expense expense = Expense("clothes", "Nike", DateTime.now(), 125.23);
  Expense expense2 = Expense(
      "shop", "Zara", DateTime.now().subtract(Duration(hours: 2)), 111.23);
  Expense expense3 =
      Expense("eat", "KFC", DateTime.now().subtract(Duration(hours: 3)), 22.23);
  Expense expense4 = Expense(
      "clothes", "Abibas", DateTime.now().subtract(Duration(hours: 4)), 65.23);
  Expense expense5 = Expense(
      "eat", "PizzaHut", DateTime.now().subtract(Duration(hours: 5)), 9.23);

  @override
  Widget build(BuildContext context) {
    expenseList.add(expense);
    expenseList.add(expense2);
    expenseList.add(expense3);
    expenseList.add(expense4);
    expenseList.add(expense5);

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print("Container tapped");
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.red,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Shops",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Row(
                children: [
                  Icon(
                    Icons.edit_note,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color(0xff07873A),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "TOTAL EXPENSES",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "\$15,312.22",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EXPENSES FOR THIS WEEK",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          "\$2.443,41",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$120.6",
                                style: TextStyle(color: Colors.white),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade300,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "MON",
                                        style:
                                            TextStyle(color: Colors.green.shade100),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$160.2",
                                style: TextStyle(color: Colors.white),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade300,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "MON",
                                        style:
                                            TextStyle(color: Colors.green.shade100),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$83.2",
                                style: TextStyle(color: Colors.white),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade300,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "MON",
                                        style:
                                            TextStyle(color: Colors.green.shade100),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$177.3",
                                style: TextStyle(color: Colors.white),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 115,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade300,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "MON",
                                        style:
                                            TextStyle(color: Colors.green.shade100),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$192.3",
                                style: TextStyle(color: Colors.white),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade300,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "MON",
                                        style:
                                            TextStyle(color: Colors.green.shade100),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$188.2",
                                style: TextStyle(color: Colors.white),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade300,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "MON",
                                        style:
                                            TextStyle(color: Colors.green.shade100),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$12.2",
                                style: TextStyle(color: Colors.white),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade300,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "MON",
                                        style:
                                            TextStyle(color: Colors.green.shade100),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),


              ),


              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.2),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ), // Adjust the radius as needed
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("EXPENSES TODAY"),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              '+ add expense',
                              style: TextStyle(
                                  color: Color(0xff41B746),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xff41B746),
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < 5; i++)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/icons/${expenseList[i].category}.png",
                                      width: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${expenseList[i].expenseName}"),
                                      Text(
                                          '${expenseList[i].expenseDate.hour}:${expenseList[i].expenseDate.minute}')
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                "\$${expenseList[i].expense}",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("EXPENSES YESTERDAY"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      for (int i = 0; i < 5; i++)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      "assets/icons/${expenseList[i].category}.png",
                                      width: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${expenseList[i].expenseName}"),
                                      Text(
                                          '${expenseList[i].expenseDate.hour}:${expenseList[i].expenseDate.minute}')
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                "\$${expenseList[i].expense}",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
