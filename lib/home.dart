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
          SizedBox(height: 20,),
          Row(
            children: [
              Icon(Icons.sunny,color: Colors.green,),
              SizedBox(width: 5,),
              Text("GOOD MORNİNG",style: TextStyle(color: Colors.green,fontSize: 16))
            ],
          )
        ],
      ),
    );
  }





  Row getDayTime(){



    return Row(
      children: [],
    );
  }
}

