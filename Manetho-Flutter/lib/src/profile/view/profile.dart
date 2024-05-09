import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:mannetho/core/helpers/spacing.dart';
import 'package:mannetho/core/routing/routes.dart';
import 'package:mannetho/core/widgets/custom_button.dart';
import 'package:mannetho/core/widgets/custom_image.dart';
import 'package:mannetho/core/widgets/custom_loading.dart';
import 'package:mannetho/src/profile/view_model/profile_cubit.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theming/color_manger.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
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
                          text: 'My Profile',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          size: 25),
                    ],
                  ),
                ),
                verticalSpace(40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [

                            BlocBuilder<ProfileCubit, ProfileState>(
                                builder: (context, state) {
                                  return Stack(
                                    alignment: AlignmentDirectional.topStart,
                                    children: [
                                      CircleAvatar(
                                        radius: 57.sp,
                                        backgroundColor: AppColors.goldColor,
                                        child: context.read<ProfileCubit>().profileImage != null
                                            ? CircleAvatar(
                                          radius: 55.sp,
                                          backgroundColor: AppColors.primaryColor,
                                          backgroundImage: FileImage(
                                            context.read<ProfileCubit>().profileImage!,
                                          ),
                                        )
                                            : context.read<ProfileCubit>().currentProfileImage == null
                                            ? CircleAvatar(
                                          radius: 55.sp,
                                          backgroundColor: AppColors.primaryColor,
                                          backgroundImage: const AssetImage(
                                            AppAssets.user,
                                          ),
                                        )
                                            : Container(
                                          height: 110.sp,
                                          width: 110.sp,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                          ),
                                          child: CustomImage(image: context.read<ProfileCubit>().currentProfileImage??'',
                                            radius: 150,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0.w,
                                          right: 0.w,
                                          child: InkWell(
                                            onTap: () {
                                              context.read<ProfileCubit>().pickProfileImage();
                                            },
                                            child: CircleAvatar(
                                              radius: 16.5.r,
                                              backgroundColor: AppColors.goldColor,
                                              child: CircleAvatar(
                                                  radius: 15.5.r,
                                                  backgroundColor: const Color(0xff1E2A2B),
                                                  child: Icon(
                                                    Icons.edit_rounded,
                                                    color: AppColors.goldColor,
                                                    size: 20.sp,
                                                  )),
                                            ),
                                          )),
                                    ],
                                  );
                                }),
                          ],
                        ),

                        verticalSpace(50),

                        CustomTextFormField(
                            controller: context.read<ProfileCubit>().nameController,
                            hint: "Name",
                            prefixIcon: Icons.person,
                            validator: (String? value){
                              if(value==null || value.isEmpty) return 'Enter your name';
                              return null;
                            },
                            context: context),

                        verticalSpace(30),

                        CustomTextFormField(
                            controller: context.read<ProfileCubit>().emailController,
                            hint: "Email",
                            prefixIcon: Icons.email_rounded,
                            isEnabled: false,
                            validator: (String? value){
                              if(value==null || value.isEmpty) return 'Enter your email';
                              return null;
                            },
                            context: context),

                        verticalSpace(90),

                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return context.read<ProfileCubit>().loadWhileUpdating
                                ? const CustomLoading()
                                : CustomButton(
                                text: 'Save',
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    context.read<ProfileCubit>().saveChanges(context);
                                  }
                                });
                          }
                        ),

                        // verticalSpace(20),
                        // CustomButton(
                        //     text: 'Edit Email',
                        //     color: AppColors.white,
                        //     withBorder: true,
                        //     function: (){
                        //       context.pushNamed(Routes.editEmail);
                        //     }),

                        verticalSpace(20),
                        CustomButton(
                            text: 'Reset Password',
                            color: AppColors.white,
                            withBorder: true,
                            function: (){
                              context.pushNamed(Routes.forgetPassword);
                            })
                      ],
                    ),
                  ),
                ),
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
