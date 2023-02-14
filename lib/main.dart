import 'package:currency_convertor/model/globals.dart';
import 'package:currency_convertor/views/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return (Globals.isIos == true)
        ? const CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          )
        : MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xff6096B4),
                secondary: const Color(0xff93BFCF),
              ),
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const HomePage(),
            },
          );
  }
}
