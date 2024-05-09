import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import '../core/routing/routes.dart';


class Splash extends StatefulWidget { const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        ()async {

              try {
                if (FirebaseAuth.instance.currentUser != null) {
                  context.pushNamedAndRemoveUntil(Routes.home,predicate: (route) => false);
                } else {
                  context.pushNamedAndRemoveUntil(Routes.login,predicate: (route) => false);
                }
              } catch (error) {
                context.pushNamedAndRemoveUntil(Routes.login, predicate: (route) => false);
              }
            }
    );
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin:Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors:[
                  Color(0xff724B27),
                  Color(0xff171715)

                ])
        ),
          child: Center(
            child: SizedBox(
              height: 105,width: 105,
              child: Image.asset("images/LOGO-re.png"),
            ),
          ) ,

      ),
    );

  }
}

