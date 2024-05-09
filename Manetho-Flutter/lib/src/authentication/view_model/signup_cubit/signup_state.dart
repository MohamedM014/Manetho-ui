part of 'signup_cubit.dart';

@immutable
abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class ChangePasswordState extends SignupStates {}

// Sign up states
class SignupLoadingState extends SignupStates {}
class SignupSuccessState extends SignupStates {}
class SignupErrorState extends SignupStates {
  String error;
  SignupErrorState(this.error);
}

class SignupWithGoogleLoadingState extends SignupStates {}
class SignupWithGoogleSuccessState extends SignupStates {}
class SignupWithGoogleErrorState extends SignupStates {}

