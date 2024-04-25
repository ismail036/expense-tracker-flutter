// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, constant_identifier_names, unnecessary_import, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_currency_rate/live_currency_rate.dart';

const int DF_CLR = 0XFF07873A;
const double SPC_BTW = 15.0;
String defaultCurrency = "Apple";

class Currency extends StatefulWidget {
  const Currency({super.key});

  @override
  State<Currency> createState() => _MainPageState();
}

class _MainPageState extends State<Currency> {
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
        "Currency Converter",
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Color(DF_CLR)),
        onPressed: () async {
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
  final List<String> items = ["Apple", "Banana", "Orange", "Mango", "Grapes"];
  String? selectedItem = defaultCurrency;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          selectedColor: Colors.white,
          selectedTileColor: Color(DF_CLR),
          title: Text(items[index]),
          // Eleman seçildiğinde setState kullanarak seçili elemanı güncelle
          onTap: () {
            setState(() {
              selectedItem = items[index];
            });
            // Seçilen elemanın index'ini bir önceki sayfaya döndür
            Navigator.pop(context, selectedItem);
          },
          // Seçili elemanı görsel olarak işaretle
          selected: selectedItem == items[index],
        );
      },
    );
  }
}

exchangeCurrency(String first, String second, double amount) async {
  CurrencyRate rate =
      await LiveCurrencyRate.convertCurrency(first, second, amount);
  return rate.result;
}
