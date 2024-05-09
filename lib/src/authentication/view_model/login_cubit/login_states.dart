

abstract class LoginStates {}
class InitialLoginState extends LoginStates{}
class ChangePasswordState extends LoginStates{}

class LoginSuccessState extends LoginStates{}
class LoginErrorState extends LoginStates{
  String error;
  LoginErrorState({required this.error});
}
class LoginLoadingState extends LoginStates{}

class LoginWithGoogleLoadingState extends LoginStates{}
class LoginWithGoogleSuccessState extends LoginStates{}
class LoginWithGoogleErrorState extends LoginStates{
  String error;
  LoginWithGoogleErrorState({required this.error});
}
