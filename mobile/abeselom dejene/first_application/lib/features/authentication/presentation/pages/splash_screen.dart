import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:first_application/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:first_application/features/product/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../injection_container.dart';
import '../../data/datasources/auth_local_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getStatus() async {
    final isLoggedIn = await locator<AuthLocalDataSource>().getLoginStatus();
    setState(() {
      isLogged = isLoggedIn;
    });
  }

  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/Smiley female volunteers posing together.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(82, 63, 81, 243),
                  Color(0xff3F51F3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: AnimatedSplashScreen(
              splash: Image.asset('assets/Group 67.png'),
              duration: 3000,
              curve: Curves.easeInOut,
              splashIconSize: 350,
              splashTransition: SplashTransition.slideTransition,
              animationDuration: const Duration(milliseconds: 1500),
              backgroundColor: Colors.transparent,
              pageTransitionType: PageTransitionType.fade,
              nextScreen: isLogged ? const HomePage() : const LoginPage(),
            ),
          ),
        ],
      ),
    );
  }
}
