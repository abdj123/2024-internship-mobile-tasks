import 'package:first_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:first_application/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:first_application/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:first_application/features/authentication/presentation/pages/splash_screen.dart';
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
        BlocProvider(
          create: (context) => locator<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/detail_page": (context) => const DetailPage(),
          "/home_page": (context) => const HomePage(),
          "/create_product": (context) => const CreateProduct(),
          "/update_product": (context) => const UpdateProduct(),
          "/search_page": (context) => const SearchPage(),
          "/register_page": (context) => const SignUpPage(),
          "/login_page": (context) => const LoginPage(),
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
