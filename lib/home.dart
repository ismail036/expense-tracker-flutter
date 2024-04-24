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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

          Row(
            children: [
              greetingText(),
            ],
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

