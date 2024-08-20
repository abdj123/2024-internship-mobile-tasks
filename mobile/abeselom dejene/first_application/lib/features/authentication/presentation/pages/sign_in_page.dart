import 'package:first_application/features/authentication/domain/entities/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/reusable_button.dart';
import '../widgets/reusable_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccessState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));

              Navigator.pushNamed(context, "/home_page");
            }
            if (state is FailuerState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset("assets/Group 67.png", width: 144, height: 50),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 65),
                    child: reusableText(
                        "Sign into your account", FontWeight.w600, 26),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("Email", FontWeight.w400, 16),
                      ReusableTextField(
                        hint: "ex: jon.smith@email.com",
                        textEditingController: emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      reusableText("Password", FontWeight.w400, 16),
                      ReusableTextField(
                        hint: "*********",
                        textEditingController: passwordController,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 68),
                    child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final user = UserEntity(
                                email: emailController.text, id: '', name: '');
                            final passwd = passwordController.text;
                            context
                                .read<AuthBloc>()
                                .add(LogInEvent(user, passwd));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please Enter Valid Data")));
                          }
                        },
                        child: const ReusableButton(lable: "SIGN IN")),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Don’t have an account? ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, "/register_page"),
                              text: "SIGN UP",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff3F51F3)))
                        ]),
                  )
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}

Text reusableText(String text, FontWeight wight, double size,
    [Color color = Colors.black]) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(fontWeight: wight, fontSize: size, color: color),
  );
}
