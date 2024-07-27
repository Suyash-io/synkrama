
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../firebase_services/auth_service.dart';
import 'auth_screen.dart';

class AuthController extends GetxController {
  final selectedIndex = 0.obs;
  final showSpinner = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  final signFormKey = GlobalKey<FormState>();
  final forgetPassFormKey = GlobalKey<FormState>();

  TextEditingController loginEmail = TextEditingController();

  TextEditingController loginPass = TextEditingController();

  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPass = TextEditingController();
  TextEditingController signUpConfirmPass = TextEditingController();
  TextEditingController userName = TextEditingController();

  TextEditingController forgetEmail = TextEditingController();

  final isObscure = true.obs;
  final isObscure2 = true.obs;
  final isTermsConditions = false.obs;
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    showSpinner.value = false;
    isObscure.value = true;
  }
   void reset() {
    isObscure.value = true;
    isObscure2.value = true;
    isTermsConditions.value = false;
    userName.clear();
    signUpEmail.clear();
    signUpPass.clear();
    signUpConfirmPass.clear();
    loginEmail.clear();
    loginPass.clear();
    forgetEmail.clear();
   }
  void checkAuth() {
    Future.delayed(const Duration(seconds: 2),
        () => {Get.offAll(() => const AuthScreen())});
  }

  Future<String> singUpUser(BuildContext context) async {
    String result = '';
    try {
      result = await AuthService.createUser(userName.text,signUpEmail.text, signUpPass.text);
    } catch (e) {
      print(e);
      result = 'failed';
    }
    print('singup finished $result');
    return result;
  }

  Future<String> userLogin(BuildContext context) async {
    String result = '';
    try {
      result = await AuthService.login(loginEmail.text, loginPass.text);
    } catch (e) {
      print(e);
      result = 'failed';
    }
    print('User Login end $result');
    return result;
  }

}
