import 'package:first_application/features/authentication/presentation/widgets/reusable_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/reusable_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.navigate_before)),
              Image.asset(
                "assets/Group 67.png",
                width: 78,
                height: 25,
              )
            ],
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));

            Navigator.pushNamed(context, "/login_page");
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
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: reusableText(
                          "Create your account", FontWeight.w600, 26)),
                  reusableText("Name", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "ex: jon smith",
                    textEditingController: nameEditingController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  reusableText("Email", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "ex: jon.smith@email.com",
                    textEditingController: emailEditingController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  reusableText("Password", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "**********",
                    textEditingController: passwordEditingController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  reusableText("Confirm password", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "**********",
                    textEditingController: confirmPasswordController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (value) {},
                      ),
                      RichText(
                        text: const TextSpan(
                            text: "I understood the ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey),
                            children: [
                              TextSpan(
                                  text: "terms & policy.",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3F51F3)))
                            ]),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        final user = UserEntity(
                            email: emailEditingController.text,
                            id: '',
                            name: nameEditingController.text);
                        final passwd = passwordEditingController.text;
                        context.read<AuthBloc>().add(SignUpEvent(user, passwd));
                      },
                      child: const ReusableButton(lable: "SIGN UP")),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                            text: "Have an account? ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(
                                        context, "/login_page"),
                                  text: "SIGN IN",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3F51F3)))
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
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
