import 'package:first_application/features/product/data/data_sources/remote_data_source.dart';
import 'package:first_application/features/product/data/repositories/product_repositorie_impl.dart';
import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
import 'package:first_application/features/product/presentation/screens/detail_page.dart';
import 'package:first_application/features/product/presentation/screens/home_page.dart';
import 'package:first_application/features/product/presentation/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/product/presentation/screens/create_product.dart';

void main() {
  final http.Client client = http.Client();

  final ProductRemoteDataSource remoteDataSource =
      ProductRemoteDataSourceImpl(client: client);

  final ProductRepositoryImpl productRepositoryImpl =
      ProductRepositoryImpl(productRemoteDataSource: remoteDataSource);

  runApp(MyApp(productRepositoryImpl: productRepositoryImpl));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl productRepositoryImpl;

  const MyApp({super.key, required this.productRepositoryImpl});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(productRepositoryImpl),
        ),
      ],
      child: MaterialApp(
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
      ),
      // ],
    );
  }
}
