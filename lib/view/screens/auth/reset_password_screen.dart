import 'package:flutter/material.dart';
import 'package:takenotes/utils/validator.dart';
import 'package:takenotes/view/widgets/bezier_container.dart';
import 'package:takenotes/view/widgets/custom_back_button.dart';
import 'package:takenotes/view/widgets/custom_button.dart';
import 'package:takenotes/view/widgets/password_input_field.dart';
import 'package:takenotes/view/widgets/text_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.2),
                    title(),
                    SizedBox(height: 50),
                    codeText(),
                    SizedBox(height: 10),
                    codeTextField(),
                    SizedBox(height: 15),
                    newPasswordText(),
                    SizedBox(height: 10),
                    newPasswordTextField(),
                    SizedBox(height: 15),
                    confirmPasswordText(),
                    SizedBox(height: 10),
                    confirmPasswordTextField(),
                    SizedBox(height: 30),
                    resetPasswordButton(),
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
      'Reset Your Password',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget codeText() {
    return Text(
      'Code',
    );
  }

  Widget codeTextField() {
    return TextInputField(
      controller: codeController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.number,
      validator: Validator.code,
    );
  }

  Widget newPasswordText() {
    return Text(
      'New Password',
    );
  }

  Widget newPasswordTextField() {
    return PasswordInputField(
      controller: newPasswordController,
      inputAction: TextInputAction.next,
      validator: Validator.password,
    );
  }

  Widget confirmPasswordText() {
    return Text(
      'Confirm Password',
    );
  }

  Widget confirmPasswordTextField() {
    return PasswordInputField(
      controller: confirmPasswordController,
      inputAction: TextInputAction.done,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please re-enter password';
        }

        if (newPasswordController.text != confirmPasswordController.text) {
          return "Passwords do not match";
        }

        return null;
      },
    );
  }

  Widget resetPasswordButton() {
    return CustomButton(
      name: 'Reset Password',
      onPressed: () {
        if (formKey.currentState.validate()) {}
      },
    );
  }
}
