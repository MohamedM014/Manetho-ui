
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/theming/color_manger.dart';
import '../../../../core/theming/font_weight_helper.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/snack_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});


  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController= TextEditingController();
  static final formKey= GlobalKey<FormState>();
  bool load= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff171715),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){context.pop();},
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white,),
        ),
        titleSpacing: 0,
        title: const CustomText(
          text: "Reset Password",
          size: 25,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff724B27), Color(0xff171715)])),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w,),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    verticalSpace(30),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage(AppAssets.logo,),
                      ),
                    ),
                    verticalSpace(40),
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeightHelper.bold,
                        color: AppColors.goldColor,
                      ),
                    ),
                    verticalSpace(8),
                    Text(
                     'Enter your email,\nA link will be sent to the email you entered,\nYou can change your password through it',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.regular,
                        color: AppColors.lighterGray,
                      )
                    ),
                    verticalSpace(36),

                    CustomTextFormField(
                        controller: emailController,
                        hint: "Email",
                        prefixIcon: Icons.email_rounded,
                        validator: (String? value){
                          if(value==null || value.isEmpty) return 'Enter your email';
                          return null;
                        },
                        context: context),

                    verticalSpace(70),

                    load ? const CustomLoading()
                        : CustomButton(
                      text: 'Send',
                      function: () {
                        if(formKey.currentState!.validate()){
                              sendToEmail(emailController.text.trim());
                            }
                          },
                    ),

                    verticalSpace(30),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  Future<void> sendToEmail(String email)async {
    try{
      setState(() {
        load= true;
      });

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      setState(() {
        load= false;
      });
      CustomSnackBarHandler.showCustomSnackBar(
          context: context, state: SnackBarStates.success, text: 'A message has been sent to your email, check the email and change your password through it');
    }catch(error){
      setState(() {
        load= false;
      });
      CustomSnackBarHandler.showCustomSnackBar(
          context: context, text: AppConstants.errorMessage);
    }
  }
}