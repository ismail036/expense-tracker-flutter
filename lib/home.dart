// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, duplicate_import, depend_on_referenced_packages, unused_import, unnecessary_brace_in_string_interps

import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:live_currency_rate/live_currency_rate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unilive/addcategory.dart';
import 'package:unilive/addearnings.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:unilive/addexpenses.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:unilive/core/extensions/l10n.extensions.dart';
import 'package:unilive/currency.dart';

import 'category.dart';
import 'db_helper.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

List<Map<String, dynamic>> data = [];
List<Map<String, dynamic>> earningData = [];
List<Map<String, dynamic>> expenseData = [];

List<Map<String, dynamic>> firstfiveearningData = [];

class _HomeBodyState extends State<HomeBody> {
  double appBarIconWidth = 30.0;

  int touchedIndex = -1;

  String selectedCurrency = "";

  String selectedTimeFilter = "day";

  List<String> abbreviatedMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  int currentMonth = DateTime.now().month;

  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 13),
    ChartData(2012, 34),
    ChartData(2013, 27),
    ChartData(2014, 40),
  ];

  double totalEarning = 0.0;
  double thisDayEarning = 0.0;

  Future<void> getEarning() async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.open();
    data = await dbHelper.getData();
    earningData.clear();
    expenseData.clear();

    for (var d in data) {
      if (d["category"] == "salary") {
        earningData.add(d);
      } else {
        expenseData.add(d);
      }
    }

    earningData = earningData.reversed.toList();

    if (earningData.length > 5) {
      firstfiveearningData = earningData.sublist(0, 5);
    }
    await setTotalEarning(); // setTotalEarning işlevini beklet
  }

  Future<void> setTotalEarning() async {
    double total = 0.0;
    double thisDay = 0.0;
    for (var earning in earningData) {
      total += earning["expense"];
      if (DateTime.parse(earning["expenseDate"]).day == DateTime.now().day) {
        thisDay += earning["expense"];
      }
    }

    setState(() {
      totalEarning = total;
      thisDayEarning = thisDay;
    });
  }

  var format = NumberFormat("#,##0.00", "tr_TR");

  @override
  Widget build(BuildContext context) {
    getEarning();
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                greetingText(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Currency()),
                        );
                        setState(() {
                          if (result != null) {
                            selectedCurrency = result;
                            print(selectedCurrency);
                          } else {
                            print("NO CHOOSE");
                          }
                        });
                      },
                      child: Image.asset(
                        'assets/icons/exchange.png',
                        width: appBarIconWidth,
                      ), // İkon boyutunu ayarlamak için width özelliğini kullanın
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('american pressed');
                        _saveCurrency("en");
                      },
                      child: Image.asset(
                        'assets/icons/american.png',
                        width: appBarIconWidth,
                      ), // Replace 'image.png' with your image file path
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('russian pressed');
                        _saveCurrency("ru");
                      },
                      child: Image.asset(
                        'assets/icons/russian.png',
                        width: appBarIconWidth,
                      ), // Replace 'image.png' with your image file path
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('brazilian pressed');
                        _saveCurrency("hu");
                      },
                      child: Image.asset(
                        'assets/icons/brazilian.png',
                        width: appBarIconWidth,
                      ), // Replace 'image.png' with your image file path
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              context.translate.recentearnings,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(
                        0xFF07873A), // Replace #07873A with your desired color
                    Color(
                        0xFF41B746), // Replace #41B746 with your desired color
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.translate.earnings,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "\$${format.format(totalEarning)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$${format.format(thisDayEarning)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${context.translate.today} ,  ${abbreviatedMonths[currentMonth - 1]} ${DateTime.now().day}',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            for (var i = 0; i < firstfiveearningData.length; i++)
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
                            "assets/icons/salary.png",
                            width: 40,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(earningData[i]["expenseName"]),
                            Text(
                                '${DateTime.parse(earningData[i]["expenseDate"]).hour}:${DateTime.parse(earningData[i]["expenseDate"]).minute}')
                          ],
                        )
                      ],
                    ),
                    Text("${earningData[i]["expense"]}",
                        style: TextStyle(fontSize: 25))
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEarnings(),
                    ));
              },
              child: Text(
                '+ ${context.translate.addearnings}',
                style: TextStyle(
                    color: Color(0xff41B746),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff41B746)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              context.translate.recentexpenses,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(
                        0xFF07873A), // Replace #07873A with your desired color
                    Color(
                        0xFF41B746), // Replace #41B746 with your desired color
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.translate.expenses,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "\$5.000",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${thisDayEarning}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    child: SfCartesianChart(
                      plotAreaBorderColor: Colors
                          .transparent, // Arka planın kenar çizgisini saydam yapar
                      plotAreaBackgroundColor:
                          Colors.transparent, // Arka plan rengini saydam yapar
                      primaryXAxis: NumericAxis(
                        isVisible: true, // X ekseni görünür
                        majorGridLines: MajorGridLines(
                            width: 0), // X ekseni çizgisini gizler
                      ),
                      primaryYAxis: NumericAxis(
                          isVisible: false), // Y ekseni çizgisini gizler
                      series: <CartesianSeries>[
                        // Spline grafik serisi
                        SplineSeries<ChartData, int>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          splineType: SplineType
                              .natural, // Spline çizgisi sonunda yuvarlak bir bitiş ekler
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${context.translate.today} ,  ${abbreviatedMonths[currentMonth - 1]} ${DateTime.now().day}',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            for (var i = 0; i < 5; i++)
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
                            "assets/icons/salary.png",
                            width: 40,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Salary"),
                            Text(
                                '${DateTime.now().hour}:${DateTime.now().minute}')
                          ],
                        )
                      ],
                    ),
                    Text(
                      "\$12.23",
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExpenes(),
                    ));
              },
              child: Text(
                '+ ${context.translate.addexpense}',
                style: TextStyle(
                    color: Color(0xff41B746),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff41B746)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(context.translate.expensesbycategory,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${context.translate.thismonth} - ${abbreviatedMonths[currentMonth - 1]}",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCategory(),
                      ),
                    );
                  },
                  child: Text(
                    '+ ${context.translate.addnewcategory}',
                    style: TextStyle(
                        color: Color(0xff41B746),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xff41B746)),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Category(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffEBEFF3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/shop.png",
                          scale: 6,
                        ),
                        Text("Shops"),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\$855",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/car.png",
                        scale: 7,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/medicine.png",
                        scale: 6,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/clothes.png",
                        scale: 6,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/petsupplies.png",
                        scale: 6,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/recreationandentertainment.png",
                        scale: 6,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/taxes.png",
                        scale: 6,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/eat.png",
                        scale: 6,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffEBEFF3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/gifts.png",
                        scale: 6,
                      ),
                      Text("Shops"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$855",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              context.translate.expensestatistics,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeFilter = "day";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedTimeFilter == "day"
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xffEBEFF3),
                          width: 2,
                        ),
                      ),
                      width: 120,
                      height: 40,
                      child: Center(
                          child: Text(
                        context.translate.aday,
                        style: TextStyle(
                            color: selectedTimeFilter == "day"
                                ? Colors.white
                                : Colors.grey[500]),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setState(() {
                          selectedTimeFilter = "week";
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedTimeFilter == "week"
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xffEBEFF3),
                          width: 2,
                        ),
                      ),
                      width: 120,
                      height: 40,
                      child: Center(
                          child: Text(
                        context.translate.aweek,
                        style: TextStyle(
                            color: selectedTimeFilter == "week"
                                ? Colors.white
                                : Colors.grey[500]),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setState(() {
                          selectedTimeFilter = "month";
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedTimeFilter == "month"
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xffEBEFF3),
                          width: 2,
                        ),
                      ),
                      width: 120,
                      height: 40,
                      child: Center(
                          child: Text(
                        context.translate.amonth,
                        style: TextStyle(
                            color: selectedTimeFilter == "month"
                                ? Colors.white
                                : Colors.grey[500]),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setState(() {
                          selectedTimeFilter = "year";
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedTimeFilter == "year"
                            ? Colors.green
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xffEBEFF3),
                          width: 2,
                        ),
                      ),
                      width: 120,
                      height: 40,
                      child: Center(
                          child: Text(
                        context.translate.ayear,
                        style: TextStyle(
                            color: selectedTimeFilter == "year"
                                ? Colors.white
                                : Colors.grey[500]),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 1,
                    centerSpaceRadius: MediaQuery.of(context).size.width / 4,
                    sections: showingSections(),
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Center(
                      child: Text(
                    "\$3.250",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ))),
            ]),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Text(
                        " ${context.translate.taxes}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Text(
                        " ${context.translate.gifts}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Text(
                        " ${context.translate.eat}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        " ${context.translate.other}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                context.translate.privacy,
                style: TextStyle(
                    color: Color(0xff41B746),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff41B746),
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row greetingText() {
    var hour = DateTime.now().hour;
    String greetingText;
    Icon icon = Icon(
      Icons.sunny_snowing,
      color: Colors.green,
    );
    if (hour >= 6 && hour < 12) {
      greetingText = context.translate.gmorning;
      icon = Icon(
        Icons.sunny_snowing,
        color: Colors.green,
      );
    } else if (hour >= 12 && hour < 18) {
      greetingText = context.translate.gday;
      icon = Icon(
        Icons.sunny,
        color: Colors.green,
      );
    } else {
      greetingText = context.translate.gnight;
      icon = Icon(
        Icons.nights_stay,
        color: Colors.green,
      );
    }

    return Row(
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(greetingText, style: TextStyle(color: Colors.green, fontSize: 16))
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 16.0;
      final radius = isTouched ? 25.0 : 25.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: 30,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.grey,
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  _saveCurrency(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedLocale', language);
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}

Future<double> exchangeCurrency(
    String first, String second, double amount) async {
  CurrencyRate rate =
      await LiveCurrencyRate.convertCurrency(first, second, amount);
  return rate.result;
}
