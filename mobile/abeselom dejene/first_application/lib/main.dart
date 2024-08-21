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

import 'features/product/domain/entities/product.dart';
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
        onGenerateRoute: _generateRoute,
        initialRoute: "/",
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }

  Route? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/home_page":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case "/create_product":
        return MaterialPageRoute(builder: (_) => const CreateProduct());
      case "/update_product":
        return MaterialPageRoute(builder: (_) => const UpdateProduct());
      case "/search_page":
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case "/register_page":
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case "/login_page":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/detail_page":
        final args = settings.arguments as ProductEntity?;
        if (args != null) {
          return MaterialPageRoute(
            builder: (_) => DetailPage(productEntity: args),
          );
        }
        return null;
      default:
        return null;
    }
  }
}
