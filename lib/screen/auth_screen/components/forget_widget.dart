
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synkrama/firebase_services/auth_service.dart';
import 'package:synkrama/screen/dashboard/dashboard_screen.dart';
import '../../../common_widgets.dart';
import '../../../string_constant.dart';
import '../auth_controller.dart';

class ForgetWidget extends StatelessWidget {
  const ForgetWidget({super.key, required this.authController});
  final AuthController authController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      color: const Color(0xD9F5F7F8),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Form(
          key: authController.forgetPassFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                KStrings.forgetPassTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.syncopate(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF38419D)),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              KWidgets.textField(
                  txtController: authController.forgetEmail,
                  hintText: 'email id',
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'email Id cannot be empty';
                    }

                    return email.isValidEmail() ? null : 'enter valid email';
                  },
                  maxLength: 30),
              SizedBox(
                height: size.height * 0.02,
              ),
              OutlinedButton(
                  onPressed: () async {
                    if (authController.forgetPassFormKey.currentState!.validate()) {
                      authController.showSpinner.value = true;
                      await AuthService.auth.sendPasswordResetEmail(email: authController.forgetEmail.text.trim());

                        authController.reset();
                        authController.selectedIndex.value = 0;

                      authController.showSpinner.value = false;
                    }
                  },
                  child: const Text('Forget Password')),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        authController.selectedIndex.value = 0;
                      },
                      child: const Text(
                        'Already have an Account?',
                      )),
                  GestureDetector(
                      onTap: () {
                        authController.selectedIndex.value = 1;
                      },
                      child: const Text('create an account'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
