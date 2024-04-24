import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

class _HomeBodyState extends State<HomeBody> {

  double appBarIconWidth = 30.0;

  List<String> abbreviatedMonths = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  int currentMonth = DateTime.now().month;

  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 13),
    ChartData(2012, 34),
    ChartData(2013, 27),
    ChartData(2014, 40),
  ];

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {
                        print('exchange pressed');
                      },
                      child: Image.asset('assets/icons/exchange.png', width: appBarIconWidth,), // İkon boyutunu ayarlamak için width özelliğini kullanın
                    ),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        print('american pressed');
                      },
                      child: Image.asset('assets/icons/american.png', width: appBarIconWidth ,), // Replace 'image.png' with your image file path
                    ),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        print('russian pressed');
                      },
                      child: Image.asset('assets/icons/russian.png',  width: appBarIconWidth,), // Replace 'image.png' with your image file path
                    ),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        print('brazilian pressed');
                      },
                      child: Image.asset('assets/icons/brazilian.png',  width: appBarIconWidth,), // Replace 'image.png' with your image file path
                    ),
                  ],
                )

              ],
            ),

            SizedBox(height: 10,),

            Text("Recent earnings",style: TextStyle(fontSize: 25,fontWeight:FontWeight.w700),),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF07873A), // Replace #07873A with your desired color
                    Color(0xFF41B746), // Replace #41B746 with your desired color
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
                      Text("Earnings",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),),
                      Text("\$5.000",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w600),),
                      Text("\$435 this day",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
                    ],
                  ),

                  Container(
                    width: 200,
                    child: SfCartesianChart(
                      plotAreaBorderColor: Colors.transparent, // Arka planın kenar çizgisini saydam yapar
                      plotAreaBackgroundColor: Colors.transparent, // Arka plan rengini saydam yapar
                      primaryXAxis: NumericAxis(
                        isVisible: true, // X ekseni görünür
                        majorGridLines: MajorGridLines(width: 0), // X ekseni çizgisini gizler
                      ),
                      primaryYAxis: NumericAxis(isVisible: false), // Y ekseni çizgisini gizler
                      series: <CartesianSeries>[
                        // Spline grafik serisi
                        SplineSeries<ChartData, int>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          splineType: SplineType.natural, // Spline çizgisi sonunda yuvarlak bir bitiş ekler
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 10,),

            Text('Today ,  ${abbreviatedMonths[currentMonth - 1]} ${DateTime.now().day}' , style: TextStyle(color: Colors.grey,fontSize: 16),),

            SizedBox(height: 10,),

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
                        child: Image.asset("assets/icons/salary.png",width: 40,),
                      ),

                      SizedBox(width: 6,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Salary"),
                          Text('${DateTime.now().hour}:${DateTime.now().minute}')
                        ],
                      )
                    ],
                  ),

                  Text("\$12.23",style: TextStyle(fontSize: 25),)

                ],
              ),
            ),

            SizedBox(height: 10,),

            GestureDetector(
              onTap: (){},
              child: Text('+ add earnings', style: TextStyle(color: Color(0xff41B746),decoration: TextDecoration.underline, decorationColor:Color(0xff41B746)),),
            ),

            SizedBox(height: 20,),

            Text("Recent expenses",style: TextStyle(fontSize: 25,fontWeight:FontWeight.w700),),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF07873A), // Replace #07873A with your desired color
                    Color(0xFF41B746), // Replace #41B746 with your desired color
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
                      Text("Earnings",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),),
                      Text("\$5.000",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w600),),
                      Text("\$435 this day",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
                    ],
                  ),

                  Container(
                    width: 200,
                    child: SfCartesianChart(
                      plotAreaBorderColor: Colors.transparent, // Arka planın kenar çizgisini saydam yapar
                      plotAreaBackgroundColor: Colors.transparent, // Arka plan rengini saydam yapar
                      primaryXAxis: NumericAxis(
                        isVisible: true, // X ekseni görünür
                        majorGridLines: MajorGridLines(width: 0), // X ekseni çizgisini gizler
                      ),
                      primaryYAxis: NumericAxis(isVisible: false), // Y ekseni çizgisini gizler
                      series: <CartesianSeries>[
                        // Spline grafik serisi
                        SplineSeries<ChartData, int>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          splineType: SplineType.natural, // Spline çizgisi sonunda yuvarlak bir bitiş ekler
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 10,),

            Text('Today ,  ${abbreviatedMonths[currentMonth - 1]} ${DateTime.now().day}' , style: TextStyle(color: Colors.grey,fontSize: 16),),

            SizedBox(height: 10,),

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
                          child: Image.asset("assets/icons/salary.png",width: 40,),
                        ),

                        SizedBox(width: 6,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Salary"),
                            Text('${DateTime.now().hour}:${DateTime.now().minute}')
                          ],
                        )
                      ],
                    ),

                    Text("\$12.23",style: TextStyle(fontSize: 25),)

                  ],
                ),
              ),

            SizedBox(height: 10,),

            GestureDetector(
              onTap: (){},
              child: Text('+ add expense', style: TextStyle(color: Color(0xff41B746),decoration: TextDecoration.underline, decorationColor:Color(0xff41B746)),),
            ),

            SizedBox(height: 20,),

            Text("Expense by category",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("This month - ${abbreviatedMonths[currentMonth-1]}" , style: TextStyle(color: Colors.grey[500]),),
                GestureDetector(
                  onTap: (){},
                  child: Text('+ add new category', style: TextStyle(color: Color(0xff41B746),decoration: TextDecoration.underline, decorationColor:Color(0xff41B746)),),
                ),

              ],
            ),


            Wrap(
              children: [
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  Row greetingText(){

    var hour = DateTime.now().hour;
    String greetingText;
    Icon icon = Icon(Icons.sunny_snowing,color: Colors.green,);
    if (hour >= 6 && hour < 12) {
      greetingText = "Good Morning";
      icon = Icon(Icons.sunny_snowing,color: Colors.green,);
    } else if (hour >= 12 && hour < 18) {
      greetingText = "Good Day";
      icon = Icon(Icons.sunny,color: Colors.green,);
    } else {
      greetingText = "Good Night";
      icon = Icon(Icons.nights_stay,color: Colors.green,);
    }

    return Row(

      children: [
        icon,
        SizedBox(width: 5,),
        Text(greetingText,style: TextStyle(color: Colors.green,fontSize: 16))
      ],
    );
  }
}


class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}

