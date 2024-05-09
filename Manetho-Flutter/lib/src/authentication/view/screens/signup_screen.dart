import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:mannetho/core/helpers/spacing.dart';
import 'package:mannetho/core/theming/color_manger.dart';
import 'package:mannetho/core/theming/font_weight_helper.dart';
import 'package:mannetho/core/widgets/custom_button.dart';
import 'package:mannetho/core/widgets/custom_loading.dart';
import 'package:mannetho/core/widgets/custom_text.dart';
import 'package:mannetho/core/widgets/custom_text_button.dart';
import 'package:mannetho/core/widgets/custom_text_form_field.dart';
import 'package:mannetho/src/authentication/view_model/signup_cubit/signup_cubit.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../../../core/widgets/snack_bar.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: BlocBuilder<SignupCubit, SignupStates>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xff724B27), Color(0xff171715)])),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: context.read<SignupCubit>().formKey,
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
                  SizedBox(height: 20.h),

                  const Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "Create Your Account",
                      color: AppColors.goldColor,
                      size: 22, fontWeight: FontWeight.w600,),
                  ),

                  SizedBox(height: 30.h),

                  // TextFormField(
                  //   //Name------------------------------
                  //   controller: context.read<SignupCubit>().nameController,
                  //   validator: (String? value){
                  //     if(value==null || value.isEmpty) return 'Enter your name';
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //       prefixIcon: const Icon(Icons.person),
                  //       prefixIconColor: Colors.grey,
                  //       hintText: " Name",
                  //       hintStyle: GoogleFonts.poppins(
                  //           fontSize: 18,
                  //           fontWeight: FontWeightHelper.medium,
                  //           color: AppColors.gray),
                  //       contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  //       filled: true,
                  //       fillColor: const Color(0xff30271e),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(
                  //             Radius.circular(50.r.r)),
                  //         borderSide: const BorderSide(color: AppColors.primaryColor),
                  //       ),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(50.r),
                  //           borderSide: const BorderSide(color: AppColors.borderColor)),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(50.r),
                  //           borderSide: const BorderSide(color: AppColors.borderColor))),
                  // ),

                  CustomTextFormField(
                      controller: context.read<SignupCubit>().nameController,
                      hint: "User Name",
                      prefixIcon: Icons.person,
                        validator: (String? value){
                          if(value==null || value.isEmpty) return 'Enter your name';
                          return null;
                        },
                      context: context),

                  verticalSpace(20),
                  CustomTextFormField(
                      controller: context.read<SignupCubit>().emailController,
                      hint: "Email",
                      prefixIcon: Icons.email_rounded,
                      validator: (String? value){
                        if(value==null || value.isEmpty) return 'Enter your email';
                        return null;
                      },
                      context: context),
                  // TextFormField(
                  //   // controller: context.read<SignupCubit>().emailController,
                  //   decoration: InputDecoration(
                  //       prefix: const Icon(Icons.email),
                  //       prefixIconColor: Colors.grey,
                  //       hintText: " Email",
                  //       hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                  //       contentPadding:
                  //           const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  //       filled: true,
                  //       fillColor: const Color(0xff30271e),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(50),
                  //           borderSide: const BorderSide(color: Colors.grey)),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(50),
                  //           borderSide: const BorderSide(color: Colors.grey))),
                  // ),

                  verticalSpace(20),
                  BlocBuilder<SignupCubit, SignupStates>(
                    buildWhen: (current, prev)=> current is ChangePasswordState || prev is ChangePasswordState,
                    builder: (context, state) {
                      return CustomTextFormField(
                          controller: context.read<SignupCubit>().passwordController,
                          hint: "Password",
                          prefixIcon: Icons.lock,
                          suffixIconPressed: (){
                            context.read<SignupCubit>().changePasswordState();
                          },
                          icon: context.read<SignupCubit>().isSecured ? Icons.open_in_full_outlined : Icons.remove_red_eye_rounded,
                          isSecured: context.read<SignupCubit>().isSecured,
                          validator: (String? value){
                            if(value==null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            else if(value.trim().length<6){
                              return 'Password must be at least 6 letters';
                            }
                            return null;
                          },
                          context: context);
                    }
                  ),
                  // TextFormField(
                  //   // controller: context.read<SignupCubit>().passwordController,
                  //   decoration: InputDecoration(
                  //       prefix: const Icon(Icons.lock),
                  //       hintText: " Password",
                  //       hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                  //       contentPadding:
                  //           const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  //       filled: true,
                  //       fillColor: const Color(0xff30271e),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(50),
                  //           borderSide: const BorderSide(color: Colors.grey)),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(50),
                  //           borderSide: const BorderSide(color: Colors.grey))),
                  // ),
                  verticalSpace(20),
                  BlocBuilder<SignupCubit, SignupStates>(
                      buildWhen: (current, prev)=> current is ChangePasswordState || prev is ChangePasswordState,
                      builder: (context, state) {
                      return CustomTextFormField(
                          controller: context.read<SignupCubit>().confirmPasswordController,
                          hint: "Re-Password",
                          prefixIcon: Icons.lock,
                          suffixIconPressed: (){
                            context.read<SignupCubit>().changePasswordState();
                          },
                          icon: context.read<SignupCubit>().isSecured ? Icons.open_in_full_outlined : Icons.remove_red_eye_rounded,
                          isSecured: context.read<SignupCubit>().isSecured,
                          validator: (String? value){
                            if(value==null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            else if(value.trim()!= context.read<SignupCubit>().passwordController.text.trim()){
                              return 'The password does not match the first one';
                            }
                            return null;
                          },
                          context: context);
                    }
                  ),

                  verticalSpace(40),

                  //Signupbutton----------------------------------------------


                  BlocBuilder<SignupCubit, SignupStates>(
                      builder: (context, state) {
                        return context.read<SignupCubit>().loadWhileSignup
                            ? const CustomLoading()
                            : CustomButton(
                          text: "Sign Up",
                          function: (){
                            context.read<SignupCubit>().validateInputsAndSignup(context);
                          },
                        );
                      }
                  ),

                  //login button /---------------------------

                  verticalSpace(20),

                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: .5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "OR",
                          style: TextStyle(
                              fontWeight: FontWeightHelper.regular,
                              fontSize: 18.sp,
                              color: Colors.grey),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: .5,
                        color: Colors.grey[400],
                      )),
                    ],
                  ),

                  verticalSpace(20),

                  BlocBuilder<SignupCubit, SignupStates>(
                    builder: (context, state) {
                      return context.read<SignupCubit>().loadGoogleSignIn
                          ? const CustomLoading()
                          : SocialLoginButton(
                        onPressed: () {
                          context.read<SignupCubit>().signInWithGoogle(context);
                        },
                        buttonType: SocialLoginButtonType.google,
                        borderRadius: 50,
                        height: 54.h,
                      );
                    }
                  ),

                  verticalSpace(30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                          text: 'You  have an account?',
                          size: 18,
                        color: Colors.white,
                        fontWeight: FontWeightHelper.medium,
                      ),
                      CustomTextButton(
                          text: 'SignIn',
                          fontSize: 19,
                          onPressed: (){
                            context.pop();
                          }),
                    ],
                  ),

                  /// Listen for screen states.
                  BlocListener<SignupCubit, SignupStates>(
                    listenWhen: (previous, current) => current is SignupErrorState || current is SignupSuccessState,
                    listener: (context, state) {
                      if(state is SignupErrorState){
                        CustomSnackBarHandler.showCustomSnackBar(
                            context: context, state: SnackBarStates.error, text: state.error
                        );
                      }else if(state is SignupSuccessState){
                        CustomSnackBarHandler.showCustomSnackBar(
                            context: context, state: SnackBarStates.success,
                            text: 'Your account created successfully'
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
          );
        }
      ),
    );
  }
}
