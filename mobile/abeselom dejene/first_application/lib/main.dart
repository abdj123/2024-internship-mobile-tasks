import 'package:first_application/detail_page.dart';
import 'package:first_application/home_page.dart';
import 'package:first_application/search_page.dart';
import 'package:flutter/material.dart';

import 'create_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/detail_page": (context) => const DetailPage(),
        "/create_product": (context) => const CreateProduct(),
        "/search_page": (context) => const SearchPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}