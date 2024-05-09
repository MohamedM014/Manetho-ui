import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/routing/routes.dart';
import '../../models/user_model.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupStates> {

  SignupCubit() : super(SignupInitialState());

  // Text form filed controllers.
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();



  bool isSecured= false;
  void changePasswordState(){
    isSecured= !isSecured;
    emit(ChangePasswordState());
  }



  void validateInputsAndSignup(BuildContext context) {
    if (formKey.currentState!.validate()) {
      signup(context);
    }
  }




  bool loadWhileSignup= false;
  Future<void> signup(BuildContext context) async {
    loadWhileSignup= true;
    emit(SignupLoadingState());

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ).then((value)async {


        if(value.user!=null){
          UserModel userModel= UserModel(
              uid: value.user!.uid,
              name: nameController.text.trim(),
              createdAt: Timestamp.now(),
              email: emailController.text.trim(),
          );
          await storeUserData(userModel).then((value)async {
            context.pushNamedAndRemoveUntil(Routes.home,
                predicate: (route) => false);
            loadWhileSignup= false;
            emit(SignupSuccessState());
          }).catchError((error){
            loadWhileSignup= false;
            emit(SignupErrorState(AppConstants.errorMessage));
          });

        }else{
          loadWhileSignup= false;
          emit(SignupErrorState(AppConstants.errorMessage));
        }

      });


    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        emit(SignupErrorState('Password must be at least 6 letters'));
      } else if (error.code == 'email-already-in-use') {
        emit(SignupErrorState('This email already exists, log in instead or use a new email'));
      }else {
        emit(SignupErrorState(AppConstants.errorMessage));
      }
    } catch (e) {
      emit(SignupErrorState(AppConstants.errorMessage));
    }
  }



  Future <void> storeUserData(UserModel userModel)async {
    await FirebaseFirestore.instance.collection(AppConstants.usersCollection)
        .doc(userModel.uid).set(userModel.toJson());
  }


  /// Save data in local storage
  Future<void> saveDataInLocal(UserModel userModel)async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    sharedPreferences.setString('uid', userModel.uid);
  }



  bool loadGoogleSignIn= false;
  /// Sign up with google.
  ///
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      loadGoogleSignIn = true;
      emit(SignupWithGoogleLoadingState());
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

        emit(SignupSuccessState());
      } else {
        loadGoogleSignIn = false;
        emit(SignupErrorState(AppConstants.errorMessage));
      }
    }catch(e){
      loadGoogleSignIn = false;
      emit(SignupErrorState(AppConstants.errorMessage));
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
           emit(SignupSuccessState());
         }).catchError((error){
           loadGoogleSignIn= false;
           emit(SignupErrorState(AppConstants.errorMessage));
         });
       }
    }).catchError((error){
      loadGoogleSignIn= false;
      emit(SignupErrorState(AppConstants.errorMessage));
    });
  }

}