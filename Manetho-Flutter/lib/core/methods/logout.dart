

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routing/routes.dart';
import '../widgets/snack_bar.dart';

/// Logout from the app
Future<void> logout(BuildContext context, String text)async {
  try{
    await FirebaseAuth.instance.signOut();
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.remove('uid');
    sharedPreferences.remove('userType');
    sharedPreferences.remove('governorate');

    CustomSnackBarHandler.showCustomSnackBar(context: context, text: text);
    context.pushNamedAndRemoveUntil(Routes.login,
        predicate: (route) => false);
  }catch(error){}
}