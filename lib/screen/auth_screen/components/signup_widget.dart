import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets.dart';
import '../../../string_constant.dart';
import '../auth_controller.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key, required this.authController});
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var keySize = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keySize),
      child: Card(
        color: const Color(0xD9F5F7F8),
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Form(
            key: authController.signFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    KStrings.signUpTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syncopate(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF38419D)),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Expanded(
                  //         child: kWidgets.textField(
                  //             txtController: authController.firstName,
                  //             hintText: 'first name',
                  //             validator: (fname) {
                  //               if (fname == null || fname.isEmpty) {
                  //                 return 'Please enter valid first name';
                  //               }
                  //               return null;
                  //             },
                  //             maxLength: 18)),
                  //     SizedBox(
                  //       width: size.width * 0.01,
                  //     ),
                  //     Expanded(
                  //         child: kWidgets.textField(
                  //             txtController: authController.lastName,
                  //             hintText: 'last name',
                  //             validator: (lname) {
                  //               if (lname == null || lname.isEmpty) {
                  //                 return 'Please enter valid last name';
                  //               }
                  //               return null;
                  //             },
                  //             maxLength: 18
                  //         )),
                  //   ],
                  // ),
                  KWidgets.textField(
                      txtController: authController.userName,
                      hintText: 'user name',
                      validator: (userName) {
                        if (userName == null || userName.isEmpty) {
                          return 'user name cannot be empty';
                        }
                        return null;
                      },
                      maxLength: 30),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  KWidgets.textField(
                      txtController: authController.signUpEmail,
                      hintText: 'email id',
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'email Id cannot be empty';
                        }
                        return email.isValidEmail()
                            ? null
                            : 'enter valid email';
                      },
                      maxLength: 30),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  KWidgets.passwordField(
                      txtController: authController.signUpPass,
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

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  KWidgets.passwordField(
                      txtController: authController.signUpConfirmPass,
                      hintText: 'confirm password',
                      isObscure: authController.isObscure2.value,
                      validator: (pass) {
                        if (pass == null || pass.isEmpty) {
                          return 'password cannot be empty';
                        }
                        else if(authController.signUpPass.text.trim()!=authController.signUpConfirmPass.text.trim()){
                          return 'password are not matching';
                        }
                        return pass.length >= 6
                            ? null
                            : 'password must contain 6 char';
                      },
                      iconPressed: () {
                        authController.isObscure2.value =
                        !authController.isObscure2.value;
                      },
                      maxLength: 20),
                  CheckboxListTile(
                      value: authController.isTermsConditions.value,
                      title: const Text('Accept Terms & Conditions..',overflow: TextOverflow.ellipsis,),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (val) {
                        authController.isTermsConditions.value =
                            val ?? !authController.isTermsConditions.value;
                      }),
                  OutlinedButton(
                      onPressed: authController.isTermsConditions.value
                          ? () async {
                              if (authController.signFormKey.currentState!
                                  .validate()) {
                                authController.showSpinner.value = true;
                                String result =
                                    await authController.singUpUser(context);
                                if (result == 'successful') {
                                  authController.reset();
                                  authController.selectedIndex.value = 0;
                                  Get.showSnackbar(const GetSnackBar(
                                    title: 'Successful',
                                    message: 'User Register Successfully',
                                    duration: Duration(milliseconds: 800),
                                  ));
                                } else {
                                  Get.showSnackbar(const GetSnackBar(
                                      title: 'Failed',
                                      message:
                                          'Something went wrong,try again'));
                                }
                                authController.showSpinner.value = false;
                              }
                            }
                          : null,
                      child: const Text('Sign Up')),
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
                          child: const Text('Forget Password',
                             )),
                      GestureDetector(
                          onTap: () {
                            authController.selectedIndex.value = 0;
                          },
                          child: const Text('Login'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
