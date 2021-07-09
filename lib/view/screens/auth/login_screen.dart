import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenotes/view/widgets/bezier_container.dart';
import 'package:takenotes/view/widgets/custom_button.dart';
import 'package:takenotes/view/widgets/password_input_field.dart';
import 'package:takenotes/view/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: -height * 0.15,
              right: -width * 0.4,
              child: BezierContainer(),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.2),
                  title(),
                  SizedBox(height: 50),
                  emailText(),
                  SizedBox(height: 10),
                  emailTextField(),
                  SizedBox(height: 20),
                  passwordText(),
                  SizedBox(height: 10),
                  passwordTextField(),
                  SizedBox(height: 20),
                  loginButton(),
                  SizedBox(height: 15),
                  forgotPassword(),
                  SizedBox(height: height * 0.1),
                  createAccount(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 't',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'aken',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'otes',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget emailText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Email Address',
      ),
    );
  }

  Widget emailTextField() {
    return TextInputField(
      controller: emailController,
      hint: 'Email Address',
      inputAction: TextInputAction.next,
      inputType: TextInputType.emailAddress,
    );
  }

  Widget passwordText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Password',
      ),
    );
  }

  Widget passwordTextField() {
    return PasswordInputField(
      hint: 'Password',
      controller: passwordController,
      inputAction: TextInputAction.done,
    );
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {},
        child: Text(
          'Forgot Password?',
        ),
      ),
    );
  }

  Widget loginButton() {
    return CustomButton(
      name: 'Login',
      onPressed: () {},
    );
  }

  Widget createAccount() {
    return RichText(
      text: TextSpan(
        text: 'Don\'t have an account? ',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: [
          WidgetSpan(
            child: InkWell(
              onTap: () {},
              child: Text(
                'Register.',
                style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
