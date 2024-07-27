import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synkrama/screen/auth_screen/components/forget_widget.dart';
import '../../string_constant.dart';
import 'auth_controller.dart';
import 'components/login_widget.dart';
import 'components/signup_widget.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final widgetList = [
      LoginWidget(authController: authController),
      SignupWidget(authController: authController),
      ForgetWidget(authController: authController)
    ];
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlurryModalProgressHUD(
        inAsyncCall: authController.showSpinner.value,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.09,
              ),
              Text(KStrings.appName,textAlign: TextAlign.center,style:GoogleFonts.syncopate(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF38419D)
              ),),
              SizedBox(
                height: size.height * 0.04,
              ),
              Obx(()=> Flexible(
                  child: widgetList.elementAt(authController.selectedIndex.value),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


