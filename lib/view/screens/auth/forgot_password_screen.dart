import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/view_models/password_vm.dart';
import 'package:takenotes/utils/validator.dart';
import 'package:takenotes/view/widgets/bezier_container.dart';
import 'package:takenotes/view/widgets/custom_back_button.dart';
import 'package:takenotes/view/widgets/custom_button.dart';
import 'package:takenotes/view/widgets/text_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.2),
                    title(),
                    SizedBox(height: 10),
                    subTitle(),
                    SizedBox(height: 50),
                    emailText(),
                    SizedBox(height: 10),
                    emailTextField(),
                    SizedBox(height: 30),
                    Provider.of<PasswordVM>(context).processing
                        ? Center(child: CircularProgressIndicator())
                        : submitButton()
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              child: CustomBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Text(
      'Forgot Password',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget subTitle() {
    return Text(
      'Please enter your email address.',
    );
  }

  Widget emailText() {
    return Text(
      'Email Address',
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

  Widget submitButton() {
    return CustomButton(
      name: 'Submit',
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          await Provider.of<PasswordVM>(context, listen: false).forgotPassword(
            email: emailController.text.trim(),
            context: context,
          );
        }
      },
    );
  }
}
