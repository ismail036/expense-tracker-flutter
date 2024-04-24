import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
            width: 10,
            height: Ma,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF07873A), // Replace #07873A with your desired color
                  Color(0xFF41B746), // Replace #41B746 with your desired color
                ],
              ),
            ),
          )



        ],
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

