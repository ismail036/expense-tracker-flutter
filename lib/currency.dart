// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, constant_identifier_names, unnecessary_import, unused_import, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_currency_rate/live_currency_rate.dart';

const int DF_CLR = 0XFF07873A;
const double SPC_BTW = 15.0;
String defaultCurrency = "Apple";

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
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        // currencyMap'ten kısaltma ve tam adı al
        final currencyCode = currencies.keys.elementAt(index);
        final currencyName = currencies[currencyCode]?["name"];
        return ListTile(
          selectedColor: Colors.white,
          selectedTileColor: Color(DF_CLR),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currencyName!),
              Text(currencyCode),
            ],
          ),
          // Eleman seçildiğinde setState kullanarak seçili elemanı güncelle
          onTap: () {
            setState(() {
              selectedItem = currencyCode;
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

Map<String, Map<String, String>> currencies = {
  "ADP": {"name": "Andorran Peseta", "symbol": "ADP"},
  "AED": {"name": "United Arab Emirates Dirham", "symbol": "AED"},
  "AFA": {"name": "Afghan Afghani (1927–2002)", "symbol": "AFA"},
  "AFN": {"name": "Afghan Afghani", "symbol": "AFN"},
  "ALK": {"name": "Albanian Lek (1946–1965)", "symbol": "ALK"},
  "ALL": {"name": "Albanian Lek", "symbol": "ALL"},
  "AMD": {"name": "Armenian Dram", "symbol": "AMD"},
  "ANG": {"name": "Netherlands Antillean Guilder", "symbol": "ANG"},
  "AOA": {"name": "Angolan Kwanza", "symbol": "AOA"},
  "AOK": {"name": "Angolan Kwanza (1977–1991)", "symbol": "AOK"},
  "AON": {"name": "Angolan New Kwanza (1990–2000)", "symbol": "AON"},
  "AOR": {"name": "Angolan Readjusted Kwanza (1995–1999)", "symbol": "AOR"},
  "ARA": {"name": "Argentine Austral", "symbol": "ARA"},
  "ARL": {"name": "Argentine Peso Ley (1970–1983)", "symbol": "ARL"},
  "ARM": {"name": "Argentine Peso (1881–1970)", "symbol": "ARM"},
  "ARP": {"name": "Argentine Peso (1983–1985)", "symbol": "ARP"},
  "ARS": {"name": "Argentine Peso", "symbol": "ARS"},
  "ATS": {"name": "Austrian Schilling", "symbol": "ATS"},
  "AUD": {"name": "Australian Dollar", "symbol": "A\$"},
  "AWG": {"name": "Aruban Florin", "symbol": "AWG"},
  "AZM": {"name": "Azerbaijani Manat (1993–2006)", "symbol": "AZM"},
  "AZN": {"name": "Azerbaijani Manat", "symbol": "AZN"},
  "BAD": {"name": "Bosnia-Herzegovina Dinar (1992–1994)", "symbol": "BAD"},
  "BAM": {"name": "Bosnia-Herzegovina Convertible Mark", "symbol": "BAM"},
  "BAN": {"name": "Bosnia-Herzegovina New Dinar (1994–1997)", "symbol": "BAN"},
  "BBD": {"name": "Barbadian Dollar", "symbol": "BBD"},
  "BDT": {"name": "Bangladeshi Taka", "symbol": "BDT"},
  "BEC": {"name": "Belgian Franc (convertible)", "symbol": "BEC"},
  "BEF": {"name": "Belgian Franc", "symbol": "BEF"},
  "BEL": {"name": "Belgian Franc (financial)", "symbol": "BEL"},
  "BGL": {"name": "Bulgarian Hard Lev", "symbol": "BGL"},
  "BGM": {"name": "Bulgarian Socialist Lev", "symbol": "BGM"},
  "BGN": {"name": "Bulgarian Lev", "symbol": "BGN"},
  "BGO": {"name": "Bulgarian Lev (1879–1952)", "symbol": "BGO"},
  "BHD": {"name": "Bahraini Dinar", "symbol": "BHD"},
  "BIF": {"name": "Burundian Franc", "symbol": "BIF"},
  "BMD": {"name": "Bermudan Dollar", "symbol": "BMD"},
  "BND": {"name": "Brunei Dollar", "symbol": "BND"},
  "BOB": {"name": "Bolivian Boliviano", "symbol": "BOB"},
  "BOL": {"name": "Bolivian Boliviano (1863–1963)", "symbol": "BOL"},
  "BOP": {"name": "Bolivian Peso", "symbol": "BOP"},
  "BOV": {"name": "Bolivian Mvdol", "symbol": "BOV"},
  "BRB": {"name": "Brazilian New Cruzeiro (1967–1986)", "symbol": "BRB"},
  "BRC": {"name": "Brazilian Cruzado (1986–1989)", "symbol": "BRC"},
  "BRE": {"name": "Brazilian Cruzeiro (1990–1993)", "symbol": "BRE"},
  "BRL": {"name": "Brazilian Real", "symbol": "R\$"},
  "BRN": {"name": "Brazilian New Cruzado (1989–1990)", "symbol": "BRN"},
  "BRR": {"name": "Brazilian Cruzeiro (1993–1994)", "symbol": "BRR"},
  "BRZ": {"name": "Brazilian Cruzeiro (1942–1967)", "symbol": "BRZ"},
  "BSD": {"name": "Bahamian Dollar", "symbol": "BSD"},
  "BTN": {"name": "Bhutanese Ngultrum", "symbol": "BTN"},
  "BUK": {"name": "Burmese Kyat", "symbol": "BUK"},
  "BWP": {"name": "Botswanan Pula", "symbol": "BWP"},
  "BYB": {"name": "Belarusian New Ruble (1994–1999)", "symbol": "BYB"},
  "BYR": {"name": "Belarusian Ruble", "symbol": "BYR"},
  "BZD": {"name": "Belize Dollar", "symbol": "BZD"},
  "CAD": {"name": "Canadian Dollar", "symbol": "CA\$"},
  "CDF": {"name": "Congolese Franc", "symbol": "CDF"},
  "CHE": {"name": "WIR Euro", "symbol": "CHE"},
  "CHF": {"name": "Swiss Franc", "symbol": "CHF"},
  "CHW": {"name": "WIR Franc", "symbol": "CHW"},
  "CLE": {"name": "Chilean Escudo", "symbol": "CLE"},
  "CLF": {"name": "Chilean Unit of Account (UF)", "symbol": "CLF"},
  "CLP": {"name": "Chilean Peso", "symbol": "CLP"},
  "CNX": {"name": "Chinese People’s Bank Dollar", "symbol": "CNX"},
  "CNY": {"name": "Chinese Yuan", "symbol": "CN¥"},
  "COP": {"name": "Colombian Peso", "symbol": "COP"},
  "COU": {"name": "Colombian Real Value Unit", "symbol": "COU"},
  "CRC": {"name": "Costa Rican Colón", "symbol": "CRC"},
  "CSD": {"name": "Serbian Dinar (2002–2006)", "symbol": "CSD"},
  "CSK": {"name": "Czechoslovak Hard Koruna", "symbol": "CSK"},
  "CUC": {"name": "Cuban Convertible Peso", "symbol": "CUC"},
  "CUP": {"name": "Cuban Peso", "symbol": "CUP"},
  "CVE": {"name": "Cape Verdean Escudo", "symbol": "CVE"},
  "CYP": {"name": "Cypriot Pound", "symbol": "CYP"},
  "CZK": {"name": "Czech Republic Koruna", "symbol": "CZK"},
  "DDM": {"name": "East German Mark", "symbol": "DDM"},
  "DEM": {"name": "German Mark", "symbol": "DEM"},
  "DJF": {"name": "Djiboutian Franc", "symbol": "DJF"},
  "DKK": {"name": "Danish Krone", "symbol": "DKK"},
  "DOP": {"name": "Dominican Peso", "symbol": "DOP"},
  "DZD": {"name": "Algerian Dinar", "symbol": "DZD"},
  "ECS": {"name": "Ecuadorian Sucre", "symbol": "ECS"},
  "ECV": {"name": "Ecuadorian Unit of Constant Value", "symbol": "ECV"},
  "EEK": {"name": "Estonian Kroon", "symbol": "EEK"},
  "EGP": {"name": "Egyptian Pound", "symbol": "EGP"},
  "ERN": {"name": "Eritrean Nakfa", "symbol": "ERN"},
  "ESA": {"name": "Spanish Peseta (A account)", "symbol": "ESA"},
  "ESB": {"name": "Spanish Peseta (convertible account)", "symbol": "ESB"},
  "ESP": {"name": "Spanish Peseta", "symbol": "ESP"},
  "ETB": {"name": "Ethiopian Birr", "symbol": "ETB"},
  "EUR": {"name": "Euro", "symbol": "€"},
  "FIM": {"name": "Finnish Markka", "symbol": "FIM"},
  "FJD": {"name": "Fijian Dollar", "symbol": "FJD"},
  "FKP": {"name": "Falkland Islands Pound", "symbol": "FKP"},
  "FRF": {"name": "French Franc", "symbol": "FRF"},
  "GBP": {"name": "British Pound Sterling", "symbol": "£"},
  "GEK": {"name": "Georgian Kupon Larit", "symbol": "GEK"},
  "GEL": {"name": "Georgian Lari", "symbol": "GEL"},
  "GHC": {"name": "Ghanaian Cedi (1979–2007)", "symbol": "GHC"},
  "GHS": {"name": "Ghanaian Cedi", "symbol": "GHS"},
  "GIP": {"name": "Gibraltar Pound", "symbol": "GIP"},
  "GMD": {"name": "Gambian Dalasi", "symbol": "GMD"},
  "GNF": {"name": "Guinean Franc", "symbol": "GNF"},
  "GNS": {"name": "Guinean Syli", "symbol": "GNS"},
  "GQE": {"name": "Equatorial Guinean Ekwele", "symbol": "GQE"},
  "GRD": {"name": "Greek Drachma", "symbol": "GRD"},
  "GTQ": {"name": "Guatemalan Quetzal", "symbol": "GTQ"},
  "GWE": {"name": "Portuguese Guinea Escudo", "symbol": "GWE"},
  "GWP": {"name": "Guinea-Bissau Peso", "symbol": "GWP"},
  "GYD": {"name": "Guyanaese Dollar", "symbol": "GYD"},
  "HKD": {"name": "Hong Kong Dollar", "symbol": "HK\$"},
  "HNL": {"name": "Honduran Lempira", "symbol": "HNL"},
  "HRD": {"name": "Croatian Dinar", "symbol": "HRD"},
  "HRK": {"name": "Croatian Kuna", "symbol": "HRK"},
  "HTG": {"name": "Haitian Gourde", "symbol": "HTG"},
  "HUF": {"name": "Hungarian Forint", "symbol": "HUF"},
  "IDR": {"name": "Indonesian Rupiah", "symbol": "IDR"},
  "IEP": {"name": "Irish Pound", "symbol": "IEP"},
  "ILP": {"name": "Israeli Pound", "symbol": "ILP"},
  "ILR": {"name": "Israeli Sheqel (1980–1985)", "symbol": "ILR"},
  "ILS": {"name": "Israeli New Sheqel", "symbol": "₪"},
  "INR": {"name": "Indian Rupee", "symbol": "₹"},
  "IQD": {"name": "Iraqi Dinar", "symbol": "IQD"},
  "IRR": {"name": "Iranian Rial", "symbol": "IRR"},
  "ISJ": {"name": "Icelandic Króna (1918–1981)", "symbol": "ISJ"},
  "ISK": {"name": "Icelandic Króna", "symbol": "ISK"},
  "ITL": {"name": "Italian Lira", "symbol": "ITL"},
  "JMD": {"name": "Jamaican Dollar", "symbol": "JMD"},
  "JOD": {"name": "Jordanian Dinar", "symbol": "JOD"},
  "JPY": {"name": "Japanese Yen", "symbol": "¥"},
  "KES": {"name": "Kenyan Shilling", "symbol": "KES"},
  "KGS": {"name": "Kyrgystani Som", "symbol": "KGS"},
  "KHR": {"name": "Cambodian Riel", "symbol": "KHR"},
  "KMF": {"name": "Comorian Franc", "symbol": "KMF"},
  "KPW": {"name": "North Korean Won", "symbol": "KPW"},
  "KRH": {"name": "South Korean Hwan (1953–1962)", "symbol": "KRH"},
  "KRO": {"name": "South Korean Won (1945–1953)", "symbol": "KRO"},
  "KRW": {"name": "South Korean Won", "symbol": "₩"},
  "KWD": {"name": "Kuwaiti Dinar", "symbol": "KWD"},
  "KYD": {"name": "Cayman Islands Dollar", "symbol": "KYD"},
  "KZT": {"name": "Kazakhstani Tenge", "symbol": "KZT"},
  "LAK": {"name": "Laotian Kip", "symbol": "LAK"},
  "LBP": {"name": "Lebanese Pound", "symbol": "LBP"},
  "LKR": {"name": "Sri Lankan Rupee", "symbol": "LKR"},
  "LRD": {"name": "Liberian Dollar", "symbol": "LRD"},
  "LSL": {"name": "Lesotho Loti", "symbol": "LSL"},
  "LTL": {"name": "Lithuanian Litas", "symbol": "LTL"},
  "LTT": {"name": "Lithuanian Talonas", "symbol": "LTT"},
  "LUC": {"name": "Luxembourgian Convertible Franc", "symbol": "LUC"},
  "LUF": {"name": "Luxembourgian Franc", "symbol": "LUF"},
  "LUL": {"name": "Luxembourg Financial Franc", "symbol": "LUL"},
  "LVL": {"name": "Latvian Lats", "symbol": "LVL"},
  "LVR": {"name": "Latvian Ruble", "symbol": "LVR"},
  "LYD": {"name": "Libyan Dinar", "symbol": "LYD"},
  "MAD": {"name": "Moroccan Dirham", "symbol": "MAD"},
  "MAF": {"name": "Moroccan Franc", "symbol": "MAF"},
  "MCF": {"name": "Monegasque Franc", "symbol": "MCF"},
  "MDC": {"name": "Moldovan Cupon", "symbol": "MDC"},
  "MDL": {"name": "Moldovan Leu", "symbol": "MDL"},
  "MGA": {"name": "Malagasy Ariary", "symbol": "MGA"},
  "MGF": {"name": "Malagasy Franc", "symbol": "MGF"},
  "MKD": {"name": "Macedonian Denar", "symbol": "MKD"},
  "MKN": {"name": "Macedonian Denar (1992–1993)", "symbol": "MKN"},
  "MLF": {"name": "Malian Franc", "symbol": "MLF"},
  "MMK": {"name": "Myanmar Kyat", "symbol": "MMK"},
  "MNT": {"name": "Mongolian Tugrik", "symbol": "MNT"},
  "MOP": {"name": "Macanese Pataca", "symbol": "MOP"},
  "MRO": {"name": "Mauritanian Ouguiya", "symbol": "MRO"},
  "MTL": {"name": "Maltese Lira", "symbol": "MTL"},
  "MTP": {"name": "Maltese Pound", "symbol": "MTP"},
  "MUR": {"name": "Mauritian Rupee", "symbol": "MUR"},
  "MVP": {"name": "Maldivian Rupee (1947–1981)", "symbol": "MVP"},
  "MVR": {"name": "Maldivian Rufiyaa", "symbol": "MVR"},
  "MWK": {"name": "Malawian Kwacha", "symbol": "MWK"},
  "MXN": {"name": "Mexican Peso", "symbol": "MX\$"},
  "MXP": {"name": "Mexican Silver Peso (1861–1992)", "symbol": "MXP"},
  "MXV": {"name": "Mexican Investment Unit", "symbol": "MXV"},
  "MYR": {"name": "Malaysian Ringgit", "symbol": "MYR"},
  "MZE": {"name": "Mozambican Escudo", "symbol": "MZE"},
  "MZM": {"name": "Mozambican Metical (1980–2006)", "symbol": "MZM"},
  "MZN": {"name": "Mozambican Metical", "symbol": "MZN"},
  "NAD": {"name": "Namibian Dollar", "symbol": "NAD"},
  "NGN": {"name": "Nigerian Naira", "symbol": "NGN"},
  "NIC": {"name": "Nicaraguan Córdoba (1988–1991)", "symbol": "NIC"},
  "NIO": {"name": "Nicaraguan Córdoba", "symbol": "NIO"},
  "NLG": {"name": "Dutch Guilder", "symbol": "NLG"},
  "NOK": {"name": "Norwegian Krone", "symbol": "NOK"},
  "NPR": {"name": "Nepalese Rupee", "symbol": "NPR"},
  "NZD": {"name": "New Zealand Dollar", "symbol": "NZ\$"},
  "OMR": {"name": "Omani Rial", "symbol": "OMR"},
  "PAB": {"name": "Panamanian Balboa", "symbol": "PAB"},
  "PEI": {"name": "Peruvian Inti", "symbol": "PEI"},
  "PEN": {"name": "Peruvian Nuevo Sol", "symbol": "PEN"},
  "PES": {"name": "Peruvian Sol (1863–1965)", "symbol": "PES"},
  "PGK": {"name": "Papua New Guinean Kina", "symbol": "PGK"},
  "PHP": {"name": "Philippine Peso", "symbol": "PHP"},
  "PKR": {"name": "Pakistani Rupee", "symbol": "PKR"},
  "PLN": {"name": "Polish Zloty", "symbol": "PLN"},
  "PLZ": {"name": "Polish Zloty (1950–1995)", "symbol": "PLZ"},
  "PTE": {"name": "Portuguese Escudo", "symbol": "PTE"},
  "PYG": {"name": "Paraguayan Guarani", "symbol": "PYG"},
  "QAR": {"name": "Qatari Rial", "symbol": "QAR"},
  "RHD": {"name": "Rhodesian Dollar", "symbol": "RHD"},
  "ROL": {"name": "Romanian Leu (1952–2006)", "symbol": "ROL"},
  "RON": {"name": "Romanian Leu", "symbol": "RON"},
  "RSD": {"name": "Serbian Dinar", "symbol": "RSD"},
  "RUB": {"name": "Russian Ruble", "symbol": "RUB"},
  "RUR": {"name": "Russian Ruble (1991–1998)", "symbol": "RUR"},
  "RWF": {"name": "Rwandan Franc", "symbol": "RWF"},
  "SAR": {"name": "Saudi Riyal", "symbol": "SAR"},
  "SBD": {"name": "Solomon Islands Dollar", "symbol": "SBD"},
  "SCR": {"name": "Seychellois Rupee", "symbol": "SCR"},
  "SDD": {"name": "Sudanese Dinar (1992–2007)", "symbol": "SDD"},
  "SDG": {"name": "Sudanese Pound", "symbol": "SDG"},
  "SDP": {"name": "Sudanese Pound (1957–1998)", "symbol": "SDP"},
  "SEK": {"name": "Swedish Krona", "symbol": "SEK"},
  "SGD": {"name": "Singapore Dollar", "symbol": "SGD"},
  "SHP": {"name": "St. Helena Pound", "symbol": "SHP"},
  "SIT": {"name": "Slovenian Tolar", "symbol": "SIT"},
  "SKK": {"name": "Slovak Koruna", "symbol": "SKK"},
  "SLL": {"name": "Sierra Leonean Leone", "symbol": "SLL"},
  "SOS": {"name": "Somali Shilling", "symbol": "SOS"},
  "SRD": {"name": "Surinamese Dollar", "symbol": "SRD"},
  "SRG": {"name": "Surinamese Guilder", "symbol": "SRG"},
  "SSP": {"name": "South Sudanese Pound", "symbol": "SSP"},
  "STD": {"name": "São Tomé & Príncipe Dobra", "symbol": "STD"},
  "SUR": {"name": "Soviet Rouble", "symbol": "SUR"},
  "SVC": {"name": "Salvadoran Colón", "symbol": "SVC"},
  "SYP": {"name": "Syrian Pound", "symbol": "SYP"},
  "SZL": {"name": "Swazi Lilangeni", "symbol": "SZL"},
  "THB": {"name": "Thai Baht", "symbol": "THB"},
  "TJR": {"name": "Tajikistani Ruble", "symbol": "TJR"},
  "TJS": {"name": "Tajikistani Somoni", "symbol": "TJS"},
  "TMM": {"name": "Turkmenistani Manat (1993–2009)", "symbol": "TMM"},
  "TMT": {"name": "Turkmenistani Manat", "symbol": "TMT"},
  "TND": {"name": "Tunisian Dinar", "symbol": "TND"},
  "TOP": {"name": "Tongan Paʻanga", "symbol": "TOP"},
  "TPE": {"name": "Timorese Escudo", "symbol": "TPE"},
  "TRL": {"name": "Turkish Lira (1922–2005)", "symbol": "TRL"},
  "TRY": {"name": "Turkish Lira", "symbol": "TRY"},
  "TTD": {"name": "Trinidad & Tobago Dollar", "symbol": "TTD"},
  "TWD": {"name": "New Taiwan Dollar", "symbol": "NT\$"},
  "TZS": {"name": "Tanzanian Shilling", "symbol": "TZS"},
  "UAH": {"name": "Ukrainian Hryvnia", "symbol": "UAH"},
  "UAK": {"name": "Ukrainian Karbovanets", "symbol": "UAK"},
  "UGS": {"name": "Ugandan Shilling (1966–1987)", "symbol": "UGS"},
  "UGX": {"name": "Ugandan Shilling", "symbol": "UGX"},
  "USD": {"name": "US Dollar", "symbol": "\$"},
  "USN": {"name": "US Dollar (Next day)", "symbol": "USN"},
  "USS": {"name": "US Dollar (Same day)", "symbol": "USS"},
  "UYI": {"name": "Uruguayan Peso (Indexed Units)", "symbol": "UYI"},
  "UYP": {"name": "Uruguayan Peso (1975–1993)", "symbol": "UYP"},
  "UYU": {"name": "Uruguayan Peso", "symbol": "UYU"},
  "UZS": {"name": "Uzbekistan Som", "symbol": "UZS"},
  "VEB": {"name": "Venezuelan Bolívar (1871–2008)", "symbol": "VEB"},
  "VEF": {"name": "Venezuelan Bolívar", "symbol": "VEF"},
  "VND": {"name": "Vietnamese Dong", "symbol": "₫"},
  "VNN": {"name": "Vietnamese Dong (1978–1985)", "symbol": "VNN"},
  "VUV": {"name": "Vanuatu Vatu", "symbol": "VUV"},
  "WST": {"name": "Samoan Tala", "symbol": "WST"},
  "XAF": {"name": "CFA Franc BEAC", "symbol": "FCFA"},
  "XAG": {"name": "Silver", "symbol": "XAG"},
  "XAU": {"name": "Gold", "symbol": "XAU"},
  "XBA": {"name": "European Composite Unit", "symbol": "XBA"},
  "XBB": {"name": "European Monetary Unit", "symbol": "XBB"},
  "XBC": {"name": "European Unit of Account (XBC)", "symbol": "XBC"},
  "XBD": {"name": "European Unit of Account (XBD)", "symbol": "XBD"},
  "XCD": {"name": "East Caribbean Dollar", "symbol": "EC\$"},
  "XDR": {"name": "Special Drawing Rights", "symbol": "XDR"},
  "XEU": {"name": "European Currency Unit", "symbol": "XEU"},
  "XFO": {"name": "French Gold Franc", "symbol": "XFO"},
  "XFU": {"name": "French UIC-Franc", "symbol": "XFU"},
  "XOF": {"name": "CFA Franc BCEAO", "symbol": "CFA"},
  "XPD": {"name": "Palladium", "symbol": "XPD"},
  "XPF": {"name": "CFP Franc", "symbol": "CFPF"},
  "XPT": {"name": "Platinum", "symbol": "XPT"},
  "XRE": {"name": "RINET Funds", "symbol": "XRE"},
  "XSU": {"name": "Sucre", "symbol": "XSU"},
  "XTS": {"name": "Testing Currency Code", "symbol": "XTS"},
  "XUA": {"name": "ADB Unit of Account", "symbol": "XUA"},
  "YDD": {"name": "Yemeni Dinar", "symbol": "YDD"},
  "YER": {"name": "Yemeni Rial", "symbol": "YER"},
  "YUD": {"name": "Yugoslavian Hard Dinar (1966–1990)", "symbol": "YUD"},
  "YUM": {"name": "Yugoslavian New Dinar (1994–2002)", "symbol": "YUM"},
  "YUN": {"name": "Yugoslavian Convertible Dinar (1990–1992)", "symbol": "YUN"},
  "YUR": {"name": "Yugoslavian Reformed Dinar (1992–1993)", "symbol": "YUR"},
  "ZAL": {"name": "South African Rand (financial)", "symbol": "ZAL"},
  "ZAR": {"name": "South African Rand", "symbol": "ZAR"},
  "ZMK": {"name": "Zambian Kwacha (1968–2012)", "symbol": "ZMK"},
  "ZMW": {"name": "Zambian Kwacha", "symbol": "ZMW"},
  "ZRN": {"name": "Zairean New Zaire (1993–1998)", "symbol": "ZRN"},
  "ZRZ": {"name": "Zairean Zaire (1971–1993)", "symbol": "ZRZ"},
  "ZWD": {"name": "Zimbabwean Dollar (1980–2008)", "symbol": "ZWD"},
  "ZWL": {"name": "Zimbabwean Dollar (2009)", "symbol": "ZWL"},
  "ZWR": {"name": "Zimbabwean Dollar (2008)", "symbol": "ZWR"}
};
