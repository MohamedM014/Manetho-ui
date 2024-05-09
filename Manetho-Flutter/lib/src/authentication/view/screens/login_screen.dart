
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/color_manger.dart';
import '../../../../core/theming/font_weight_helper.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../view_model/login_cubit/login_cubit.dart';
import '../../view_model/login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async =>false,
      child: Scaffold(
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: context.read<LoginCubit>().formKey,
            child: ListView(children: [
              verticalSpace(26),

              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 95.w,
                  height: 95.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.goldColor),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Image.asset(
                    "images/LOGO.png",
                  ),
                ),
              ),
              verticalSpace(20),
              const Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: "Login",
                  color: AppColors.goldColor,
                  size: 22, fontWeight: FontWeight.w600,),
              ),

              SizedBox(height: 30.h),

              //
              // TextFormField(
              //   decoration: InputDecoration(
              //       prefix: const Icon(Icons.email,color: Color.fromARGB(255, 128 , 128, 128),),
              //       hintText: " Email",
              //       hintStyle: const TextStyle(fontSize: 18,color: Colors.grey),
              //
              //       contentPadding: const EdgeInsets.symmetric(vertical: 2,horizontal: 20),
              //       filled: true, fillColor: const Color(0xff30271e),
              //       border: OutlineInputBorder(
              //           gapPadding: 40,
              //           borderRadius: BorderRadius.circular(50),
              //           borderSide: const BorderSide(color: Colors.grey)
              //
              //
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(50),
              //           borderSide: const BorderSide(color: Colors.grey))
              //   ),
              // ),

              CustomTextFormField(
                  controller: context.read<LoginCubit>().emailController,
                  hint: "Email",
                  prefixIcon: Icons.email_rounded,
                  validator: (String? value){
                    if(value==null || value.isEmpty) return 'Enter your email';
                    return null;
                  },
                  context: context),

              verticalSpace(20),

              BlocBuilder<LoginCubit, LoginStates>(
                  buildWhen: (current, prev)=> current is ChangePasswordState || prev is ChangePasswordState,
                  builder: (context, state) {
                    return CustomTextFormField(
                        controller: context.read<LoginCubit>().passwordController,
                        hint: "Password",
                        prefixIcon: Icons.lock,
                        suffixIconPressed: (){
                          context.read<LoginCubit>().changePasswordState();
                        },
                        icon: context.read<LoginCubit>().isSecured ? Icons.open_in_full_outlined : Icons.remove_red_eye_rounded,
                        isSecured: context.read<LoginCubit>().isSecured,
                        validator: (String? value){
                          if(value==null || value.isEmpty) {
                            return 'Enter your password';
                          }
                          return null;
                        },
                        context: context);
                  }
              ),

              verticalSpace(50),

              BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return context.read<LoginCubit>().loadWhileLogin
                        ? const CustomLoading()
                        : CustomButton(
                      text: "Login",
                      function: (){
                        context.read<LoginCubit>().validateInputsAndLogin(context);
                      },
                    );
                  }
              ),
              //sign up button /---------------------------


              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CustomTextButton(
                      textColor: Colors.white,
                      fontWeight: FontWeight.w400,
                      text: 'Forgot Password ?', onPressed: (){
                    context.pushNamed(Routes.forgetPassword);
                  })),

              // Container(height: 20),


              Row(
                children: [
                  Expanded(child: Divider(thickness: .5,color: Colors.grey[400],)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR",style: TextStyle(color: Colors.grey),),
                  ),
                  Expanded(child: Divider(thickness: .5,color: Colors.grey[400],)),
                ],
              ),

              Container(height: 30),

              BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return context.read<LoginCubit>().loadGoogleSignIn
                        ? const CustomLoading()
                        : SocialLoginButton(
                      onPressed: (){
                        context.read<LoginCubit>().signInWithGoogle(context);
                      },
                      buttonType: SocialLoginButtonType.google,
                      borderRadius: 54.h,);
                  }
              ),


              verticalSpace(60),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Don\'t have an account?',
                    size: 18,
                    color: Colors.white,
                    fontWeight: FontWeightHelper.medium,
                  ),
                  CustomTextButton(
                      text: 'SignUp',
                      fontSize: 19,
                      onPressed: (){
                        context.pushNamed(Routes.signup);
                      }),
                ],
              ),

              /// Listen for screen states.
              BlocListener<LoginCubit, LoginStates>(
                listenWhen: (previous, current) => current is LoginErrorState || current is LoginSuccessState,
                listener: (context, state) {
                  if(state is LoginErrorState){
                    CustomSnackBarHandler.showCustomSnackBar(
                        context: context, state: SnackBarStates.error, text: state.error
                    );
                  }else if(state is LoginSuccessState){
                    CustomSnackBarHandler.showCustomSnackBar(
                        context: context, state: SnackBarStates.success,
                        text: 'Logged in successfully'
                    );
                    // context.pushNamed(Routes.otpRoute, arguments: state.token);
                  }
                },
                child: const SizedBox.shrink(),
              ),
              verticalSpace(30),
            ]),
          ),
        ),
      ),

    );
  }
}