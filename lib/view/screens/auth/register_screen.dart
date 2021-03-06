import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/view_models/registration_vm.dart';
import 'package:takenotes/utils/validator.dart';
import 'package:takenotes/view/screens/auth/login_screen.dart';
import 'package:takenotes/view/widgets/bezier_container.dart';
import 'package:takenotes/view/widgets/custom_button.dart';
import 'package:takenotes/view/widgets/password_input_field.dart';
import 'package:takenotes/view/widgets/text_input_field.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _showConfirmPassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.2),
                      title(),
                      SizedBox(height: 50),
                      usernameText(),
                      SizedBox(height: 10),
                      usernameTextField(),
                      SizedBox(height: 15),
                      emailText(),
                      SizedBox(height: 10),
                      emailTextField(),
                      SizedBox(height: 15),
                      passwordText(),
                      SizedBox(height: 10),
                      passwordTextField(),
                      SizedBox(height: 15),
                      confirmPasswordText(),
                      SizedBox(height: 10),
                      confirmPasswordTextField(),
                      SizedBox(height: 20),
                      Provider.of<RegistrationVM>(context).processing
                          ? CircularProgressIndicator()
                          : registerButton(),
                      SizedBox(height: height * 0.08),
                      login(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
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

  Widget usernameText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Username',
      ),
    );
  }

  Widget usernameTextField() {
    return TextInputField(
      controller: usernameController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.name,
      validator: Validator.username,
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
      inputAction: TextInputAction.next,
      inputType: TextInputType.emailAddress,
      validator: Validator.email,
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
      controller: passwordController,
      inputAction: TextInputAction.next,
      validator: Validator.password,
      obscureText: _showPassword,
      toggle: () => setState(() => _showPassword = !_showPassword),
    );
  }

  Widget confirmPasswordText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Confirm Password',
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return PasswordInputField(
      controller: confirmPasswordController,
      inputAction: TextInputAction.done,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please re-enter password';
        }

        if (passwordController.text != confirmPasswordController.text) {
          return "Password does not match";
        }

        return null;
      },
      obscureText: _showConfirmPassword,
      toggle: () =>
          setState(() => _showConfirmPassword = !_showConfirmPassword),
    );
  }

  Widget registerButton() {
    return CustomButton(
      name: 'Register Now',
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          await Provider.of<RegistrationVM>(context, listen: false).register(
            username: usernameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            confirmPassword: confirmPasswordController.text.trim(),
            context: context,
          );
        }
      },
    );
  }

  Widget login() {
    return RichText(
      text: TextSpan(
        text: 'Already have an account? ',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: [
          WidgetSpan(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: Text(
                'Login.',
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
