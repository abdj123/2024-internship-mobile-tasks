import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
import 'package:first_application/features/product/presentation/screens/detail_page.dart';
import 'package:first_application/features/product/presentation/screens/home_page.dart';
import 'package:first_application/features/product/presentation/screens/search_page.dart';
import 'package:first_application/features/product/presentation/screens/update_product_page.dart';
import 'package:first_application/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/product/presentation/screens/create_product.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ProductBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const HomePage(),
          "/detail_page": (context) => const DetailPage(),
          "/create_product": (context) => const CreateProduct(),
          "/update_product": (context) => const UpdateProduct(),
          "/search_page": (context) => const SearchPage(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
      // ],
    );
  }
}
