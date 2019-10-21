import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:example/app/routes.dart';
import 'package:example/app/pages/home/home_module.dart';
import 'package:example/app/pages/login/login_module.dart';
import 'package:example/app/shared/styles/theme_style.dart';
import 'package:example/app/shared/locale/locales.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
=======
import 'package:example/app/pages/home/home_module.dart';
>>>>>>> 2f431f953aed90d425f32232a3317fd7f82f3bb4

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
<<<<<<< HEAD
      theme: AppTheme().themeData(),
      routes: AppRoutes().routeMain(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppLocaleDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
        // const Locale('en'),
      ],
=======
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeModule(),
>>>>>>> 2f431f953aed90d425f32232a3317fd7f82f3bb4
    );
  }
}
