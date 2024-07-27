
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synkrama/screen/dashboard/dashboard_screen.dart';
import '../../../common_widgets.dart';
import '../../../string_constant.dart';
import '../auth_controller.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key, required this.authController});
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
          key: authController.loginFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                KStrings.loginTitle,
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
                  txtController: authController.loginEmail,
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
              Obx(()=> KWidgets.passwordField(
                    txtController: authController.loginPass,
                    hintText: 'password',
                    isObscure: authController.isObscure.value,
                    validator: (pass) {
                      if (pass == null || pass.isEmpty) {
                        return 'password cannot be empty';
                      }
                      return pass.length >= 6
                          ? null
                          : 'password must contain 6 char';
                    },
                    iconPressed: () {
                      authController.isObscure.value =
                      !authController.isObscure.value;
                    },
                    maxLength: 20),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              OutlinedButton(
                  onPressed: () async {
                    if (authController.loginFormKey.currentState!.validate()) {
                      authController.showSpinner.value = true;
                      String result = await authController.userLogin(context);
                      if (result == 'successful') {
                        authController.reset();
                        Get.offAll(() => const DashboardScreen());
                      } else {
                        Get.snackbar(
                            'Failed', 'something went wrong,try again');
                      }
                      authController.showSpinner.value = false;
                    }
                  },
                  child: const Text('Login')),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        authController.selectedIndex.value = 2;
                        authController.reset();
                      },
                      child: const Text(
                        'Forget Password',
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
