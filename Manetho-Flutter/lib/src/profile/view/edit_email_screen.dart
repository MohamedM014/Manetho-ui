import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:mannetho/core/helpers/spacing.dart';
import 'package:mannetho/core/widgets/custom_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theming/color_manger.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class EditEmailScreen extends StatelessWidget {
  EditEmailScreen({super.key});

  TextEditingController emailController= TextEditingController(text: 'mohamed nasser');
  static final formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xff724B27), Color(0xff171715)])),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0.w),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 32.r,
                            )),
                        const CustomText(
                            text: 'Edit Email',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            size: 25),
                      ],
                    ),
                  ),
                  verticalSpace(40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          backgroundColor: AppColors.borderColor,
                          child: CircleAvatar(
                            radius: 58.r,
                            backgroundColor: AppColors.lighterGray,
                            backgroundImage: const AssetImage(
                              AppAssets.logo,
                            ),
                          ),
                        ),

                        verticalSpace(70),

                        CustomTextFormField(
                            controller: emailController,
                            hint: "Email",
                            prefixIcon: Icons.email_rounded,
                            validator: (String? value){
                              if(value==null || value.isEmpty) return 'Enter your email';
                              return null;
                            },
                            context: context),

                        verticalSpace(90),

                        CustomButton(
                            text: 'Save',
                            function: ()async {

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

                              // FirebaseAuth.instance.signInWithEmailAndPassword(
                              //     email: 'mohamed@gmail.com',
                              //     password: 'm12315'
                              // ).then((value)async {
                                await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(
                                  'mohamednasser12315@gmail.com',);
                              // });


                            }),
                        // BlocBuilder<ProfileCubit, ProfileState>(
                        //   builder: (context, state) {
                        //     return context.read<ProfileCubit>().loadWhileUpdating
                        //         ? const CustomLoading()
                        //         : CustomButton(
                        //         text: 'Save',
                        //         function: (){
                        //           context.read<ProfileCubit>().updateUserData(context);
                        //         });
                        //   }
                        // ),

                        verticalSpace(20),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
