import 'package:byte_brief/screens/home_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(16, 13, 34, 1),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(16, 13, 34, 1),
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Color.fromRGBO(16, 13, 34, 1),
          )),
      home: const HomePage(),
    );
  }
}
