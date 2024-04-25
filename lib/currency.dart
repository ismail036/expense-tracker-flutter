// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, constant_identifier_names, unnecessary_import, unused_import, avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_currency_rate/live_currency_rate.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int defaultColor = 0xFF07873A;
const double spaceBetween = 15.0;
const String defaultCurrency = "Euro";

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.white,
      shadowColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Currency Converter",
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Color(defaultColor)),
        onPressed: () async {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildBody() {
    return MyBody();
  }
}

class MyBody extends StatefulWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  String? selectedItem;
  String selectedItemCode = defaultCurrency;

  @override
  void initState() {
    super.initState();
    _loadCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        final currencyCode = currencies.keys.elementAt(index);
        final currencyName = currencies[currencyCode]?["name"];
        return ListTile(
          selectedColor: Colors.white,
          selectedTileColor: Color(defaultColor),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currencyName!),
              Text(currencyCode),
            ],
          ),
          onTap: () {
            setState(() {
              selectedItem = currencyCode;
              selectedItemCode = currencyName!;
            });
            _saveCurrency(currencyName, currencyCode);
          },
          selected: selectedItemCode == currencyName,
        );
      },
    );
  }

  _loadCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedItemCode = prefs.getString('currency') ?? defaultCurrency;
    });
  }

  _saveCurrency(String currencyDF, currencyCodeDF) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', currencyDF);
    await prefs.setString('currencyCode', currencyCodeDF);
  }
}

Map<String, Map<String, String>> currencies = {
  "EUR": {"name": "Euro", "symbol": "€"},
  "USD": {"name": "US Dollar", "symbol": "\$"},
  "RUB": {"name": "Russian Ruble", "symbol": "RUB"},
  "BRL": {"name": "Brazilian Real", "symbol": "R\$"},
  "AED": {"name": "United Arab Emirates Dirham", "symbol": "AED"},
  "AFN": {"name": "Afghan Afghani", "symbol": "AFN"},
  "ALL": {"name": "Albanian Lek", "symbol": "ALL"},
  "AMD": {"name": "Armenian Dram", "symbol": "AMD"},
  "ANG": {"name": "Netherlands Antillean Guilder", "symbol": "ANG"},
  "AOA": {"name": "Angolan Kwanza", "symbol": "AOA"},
  "ARS": {"name": "Argentine Peso", "symbol": "ARS"},
  "AUD": {"name": "Australian Dollar", "symbol": "A\$"},
  "AZN": {"name": "Azerbaijani Manat", "symbol": "AZN"},
  "BAM": {"name": "Bosnia-Herzegovina Convertible Mark", "symbol": "BAM"},
  "BGN": {"name": "Bulgarian Lev", "symbol": "BGN"},
  "BHD": {"name": "Bahraini Dinar", "symbol": "BHD"},
  "CAD": {"name": "Canadian Dollar", "symbol": "CA\$"},
  "CHF": {"name": "Swiss Franc", "symbol": "CHF"},
  "CNY": {"name": "Chinese Yuan", "symbol": "CN¥"},
  "COP": {"name": "Colombian Peso", "symbol": "COP"},
  "CUP": {"name": "Cuban Peso", "symbol": "CUP"},
  "CZK": {"name": "Czech Republic Koruna", "symbol": "CZK"},
  "DOP": {"name": "Dominican Peso", "symbol": "DOP"},
  "FJD": {"name": "Fijian Dollar", "symbol": "FJD"},
  "FKP": {"name": "Falkland Islands Pound", "symbol": "FKP"},
  "GBP": {"name": "British Pound Sterling", "symbol": "£"},
  "HKD": {"name": "Hong Kong Dollar", "symbol": "HK\$"},
  "IQD": {"name": "Iraqi Dinar", "symbol": "IQD"},
  "JPY": {"name": "Japanese Yen", "symbol": "¥"},
  "KWD": {"name": "Kuwaiti Dinar", "symbol": "KWD"},
  "LYD": {"name": "Libyan Dinar", "symbol": "LYD"},
  "MXN": {"name": "Mexican Peso", "symbol": "MX\$"},
  "NZD": {"name": "New Zealand Dollar", "symbol": "NZ\$"},
  "PGK": {"name": "Papua New Guinean Kina", "symbol": "PGK"},
  "RON": {"name": "Romanian Leu", "symbol": "RON"},
  "SAR": {"name": "Saudi Riyal", "symbol": "SAR"},
  "SDG": {"name": "Sudanese Pound", "symbol": "SDG"},
  "SGD": {"name": "Singapore Dollar", "symbol": "SGD"},
  "TMT": {"name": "Turkmenistani Manat", "symbol": "TMT"},
  "TND": {"name": "Tunisian Dinar", "symbol": "TND"},
  "TRY": {"name": "Turkish Lira", "symbol": "TRY"},
  "TWD": {"name": "New Taiwan Dollar", "symbol": "NT\$"},
  "UYU": {"name": "Uruguayan Peso", "symbol": "UYU"},
  "VND": {"name": "Vietnamese Dong", "symbol": "₫"},
  "YER": {"name": "Yemeni Rial", "symbol": "YER"},
  "ZWL": {"name": "Zimbabwean Dollar", "symbol": "ZWL"}
};
