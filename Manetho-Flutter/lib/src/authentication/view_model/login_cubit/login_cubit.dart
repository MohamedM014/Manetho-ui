

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/methods/get_message_from_firebase_error.dart';
import '../../../../core/routing/routes.dart';
import '../../models/user_model.dart';
import 'login_states.dart';


class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(InitialLoginState());



  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();



  bool isSecured= false;
  void changePasswordState(){
    isSecured= !isSecured;
    emit(ChangePasswordState());
  }



  // check if the inputs are null.
  void validateInputsAndLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      login(context);
    }
  }


  bool loadWhileLogin= false;
  void login(BuildContext context,)async {
    loadWhileLogin= true;
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
         ).then((value)async {

          if(value.user==null){
            loadWhileLogin= false;
            emit(LoginErrorState(error: AppConstants.errorMessage));
          }else{
            await getUserDataAndGoToHome(value.user!.uid, context);
          }

    }).catchError((error){ /// TODO copy this in sign up.
      if(error== FirebaseAuthException){
        loadWhileLogin= false;
        emit(LoginErrorState(error: getMessageFromErrorCode(error.code)));
      }else{
        loadWhileLogin= false;
        emit(LoginErrorState(error: AppConstants.errorMessage));
      }
    });
  }


  Future<void> getUserDataAndGoToHome(String userId, BuildContext context)async {
    FirebaseFirestore.instance.collection(AppConstants.usersCollection)
        .doc(userId).get().then((value)async {
          if(value.exists){
            UserModel userModel= UserModel.fromJson(value.data()!);

            context.pushNamedAndRemoveUntil(Routes.home,
                predicate: (route) => false);
            loadWhileLogin= false;
            emit(LoginSuccessState());

      }else{
            loadWhileLogin= false;
            emit(LoginErrorState(error: AppConstants.errorMessage));
          }
    }).catchError((error){
      loadWhileLogin= false;
      emit(LoginErrorState(error: AppConstants.errorMessage));
    });
  }



  bool loadGoogleSignIn= false;
  /// Sign up with google.
  ///
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      loadGoogleSignIn = true;
      emit(LoginWithGoogleLoadingState());
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          name: userCredential.additionalUserInfo!.username,
          createdAt: Timestamp.now(),
          email: userCredential.user!.email ?? '',
        );
        await checkIfTheUserExist(userModel, context);

        emit(LoginWithGoogleSuccessState());
      } else {
        loadGoogleSignIn = false;
        emit(LoginWithGoogleErrorState(error: AppConstants.errorMessage));
      }
    } catch(e){
      loadGoogleSignIn = false;
      emit(LoginWithGoogleErrorState(error: AppConstants.errorMessage));
    }
  }


  Future<void> checkIfTheUserExist(UserModel userModel, BuildContext context)async {
    FirebaseFirestore.instance.collection(AppConstants.usersCollection)
        .doc(userModel.uid).get().then((value)async {
      if(value.exists){
        context.pushNamedAndRemoveUntil(Routes.home,
            predicate: (route) => false);

      }else {

        await storeUserData(userModel).then((value)async {
          context.pushNamedAndRemoveUntil(Routes.home,
              predicate: (route) => false);
          loadGoogleSignIn= false;
          emit(LoginWithGoogleSuccessState());
        }).catchError((error){
          loadGoogleSignIn= false;
          emit(LoginWithGoogleErrorState(error:AppConstants.errorMessage));
        });
      }
    }).catchError((error){
      loadGoogleSignIn= false;
      emit(LoginWithGoogleErrorState(error:AppConstants.errorMessage));
    });
  }

  Future <void> storeUserData(UserModel userModel)async {
    await FirebaseFirestore.instance.collection(AppConstants.usersCollection)
        .doc(userModel.uid).set(userModel.toJson());
  }
}