import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode() => ThemeData(
      fontFamily: 'Jannah',
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        button: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        headline1: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        caption: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        overline: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        headline2: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        headline3: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        headline4: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        headline5: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        headline6: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
        subtitle2: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        ),
      ),
    );

ThemeData darkMode() => ThemeData(
      fontFamily: 'Jannah',
      scaffoldBackgroundColor: HexColor('333739'),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      fixTextFieldOutlineLabel: true,
      appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: HexColor('333739'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontFamily: 'Jannah',
        ),
        button: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        headline1: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        caption: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        overline: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        headline2: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        headline3: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        headline4: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        headline5: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        headline6: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
        subtitle2: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
        ),
      ),
    );
