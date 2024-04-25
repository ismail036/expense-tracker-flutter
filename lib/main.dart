// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilive/addcategory.dart';
import 'package:unilive/addearnings.dart';
import 'package:unilive/addexpenses.dart';
import 'package:unilive/currency.dart';
import 'package:unilive/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff07873A),
      statusBarIconBrightness: Brightness.light,
    ));

    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // Başlangıç dilini burada ayarlayabilirsiniz, örneğin İngilizce
        locale: const Locale('en'),
        // Üstte belirttiğiniz desteklenen diller arasında öncelikli olarak kullanılacak dil
        // Varsayılan olarak ayarlanmamışsa cihazın yerel dilini kullanır
        // localeResolutionCallback: (locale, supportedLocales) {
        //   return locale;
        // },,
        //
        theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0),
          fontFamily: 'DINPro',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
