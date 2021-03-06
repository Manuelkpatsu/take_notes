import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takenotes/core/view_models/registration_vm.dart';
import 'package:takenotes/utils/validator.dart';
import 'package:takenotes/view/widgets/bezier_container.dart';
import 'package:takenotes/view/widgets/custom_back_button.dart';
import 'package:takenotes/view/widgets/custom_button.dart';
import 'package:takenotes/view/widgets/text_input_field.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const routeName = '/verify_email';

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
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
                      SizedBox(height: 15),
                      codeText(),
                      SizedBox(height: 10),
                      codeTextField(),
                      SizedBox(height: 30),
                      Provider.of<RegistrationVM>(context).processing
                          ? Center(child: CircularProgressIndicator())
                          : verifyEmailButton(),
                      SizedBox(height: 15),
                    ],
                  ),
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
      'Verify Your Email',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget subTitle() {
    return Text(
      'Please enter the code sent to your email and verify the email.',
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
      validator: Validator.code,
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
      inputAction: TextInputAction.done,
      inputType: TextInputType.number,
      validator: Validator.code,
    );
  }

  Widget verifyEmailButton() {
    return CustomButton(
      name: 'Verify Email',
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          await Provider.of<RegistrationVM>(context, listen: false).activateAccount(
            email: emailController.text.trim(),
            code: codeController.text.trim(),
            context: context,
          );
        }
      },
    );
  }
}
