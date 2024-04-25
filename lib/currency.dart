// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, constant_identifier_names, unnecessary_import, unused_import, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_currency_rate/live_currency_rate.dart';

const int DF_CLR = 0XFF07873A;
const double SPC_BTW = 15.0;
String defaultCurrency = "Apple";

// Kısaltmaları ve tam adları içeren bir Map oluştur
final Map<String, String> currencyMap = {
  "EURO": "APL",
  "United States Dollar": "BNN",
  "Brazzilian Real": "ORG",
  "Argetine peso": "MNG",
  "Mexican peso": "GRP",
  "Afghani": "APL",
  "Algerian Dinar": "ORG",
  "Armenian Dram": "GRP",
  "Australian Dolar": "BNN",
  "Azerbaijan Manat": "ORG",
  "Argetine peso": "MNG",
  "Mexican peso": "GRP",
  "United States Dollar": "BNN",
  "Brazzilian Real": "ORG",
  "Argetine peso": "MNG",
  "Mexican peso": "GRP",
  "United States Dollar": "BNN",
  "Brazzilian Real": "ORG",
  "Argetine peso": "MNG",
  "Mexican peso": "GRP",
};

// JSON dosyasının yolunu belirtin
String jsonDosyaYolu = 'lib/currency.json';

// JSON dosyasını okuyun
String jsonString = File(jsonDosyaYolu).readAsStringSync();

// JSON'u haritaya dönüştür
Map<String, dynamic> jsonMap = json.decode(jsonString);

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

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
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

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
  const MyBody({Key? key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  String? selectedItem = defaultCurrency;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jsonMap.length,
      itemBuilder: (context, index) {
        // currencyMap'ten kısaltma ve tam adı al
        final currencyName = jsonMap['name_plural'];
        final currencyCode = jsonMap['code'];

        return ListTile(
          selectedColor: Colors.white,
          selectedTileColor: Color(DF_CLR),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currencyName),
              Text(currencyCode),
            ],
          ),
          // Eleman seçildiğinde setState kullanarak seçili elemanı güncelle
          onTap: () {
            setState(() {
              selectedItem = currencyName;
            });
            // Seçilen elemanın index'ini bir önceki sayfaya döndür
            Navigator.pop(context, selectedItem);
          },
          // Seçili elemanı görsel olarak işaretle
          selected: selectedItem == currencyName,
        );
      },
    );
  }
}

Future<double> exchangeCurrency(
    String first, String second, double amount) async {
  CurrencyRate rate =
      await LiveCurrencyRate.convertCurrency(first, second, amount);
  return rate.result;
}
