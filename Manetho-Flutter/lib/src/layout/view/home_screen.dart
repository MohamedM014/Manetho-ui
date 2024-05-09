import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mannetho/core/widgets/custom_loading.dart';
import 'package:mannetho/core/widgets/custom_text_form_field.dart';
import 'package:mannetho/core/widgets/snack_bar.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/color_manger.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_text.dart';
import '../view_model/main_cubit.dart';
import 'load_user_shimmer.dart';

class HomePage  extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<MainCubit, MainAppStates>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              backgroundColor: const Color(0xff171715),
              iconTheme: const IconThemeData(color: Color(0xffEEB619)),
              leading: BlocBuilder<MainCubit, MainAppStates>(
                  builder: (context, state) {
                    return context.read<MainCubit>().loadWhileGetUser
                        ? const LoadUserImageShimmer()
                        : Padding(
                      padding: EdgeInsets.all(6.0.w),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.goldColor, width: 1.5)
                        ),
                        child: CustomImage(image: context.read<MainCubit>().currentUser.image??'',
                          radius: 150,
                        ),
                      ),
                    );
                  }
              ),

              elevation: 0,
              title: BlocBuilder<MainCubit, MainAppStates>(
                  builder: (context, state) {
                    return 1>0//context.read<MainCubit>().loadWhileGetUser
                        ? const LoadUserDataShimmer()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        CustomText(
                          text: "Hi, ${context.read<MainCubit>().currentUser.name??''}!",
                          size: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        const CustomText(
                          text: "Enjoy Your Time",
                          size: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ],
                    );
                  }
              ),
              actions: [
                IconButton(
                    onPressed: () => ZoomDrawer.of(context)!.toggle(),
                    icon: Icon(
                      Icons.menu,
                      size: 38.r,
                      color:  Colors.white,
                    )),
                horizontalSpace(10),

              ],
            ),
            body: Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xff724B27),
                        Color(0xff171715)])),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                children: [


                  Container(
                    //B1-----------------------------------------------------------
                    width: double.infinity,
                    height: 54.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff30271e),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: ListTile(
                      trailing: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                        onPressed: () {},
                      ),
                      title: const CustomText(
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        text: 'English',
                      ),
                      leading: const Icon(
                        Icons.language,
                        color: Colors.white70,
                        size: 25,
                      ),
                    ),

                  ),
                  verticalSpace(21),

                  Container(
                    // Box2------------------------------------------------------------------------
                      width: 700,
                      height: 271.h,

                      decoration: BoxDecoration(
                        color: const Color(0xff30271e),
                        borderRadius: BorderRadius.all(Radius.circular(17.r)),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Icon(Icons.volume_up_rounded,color:Colors.white70,),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.volume_up_rounded),
                                color: const Color(0xffffd700),
                              ),
                              const CustomText(
                                size: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffd700),
                                text: 'Old Egyptian',
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 8.h),
                              child: Column(
                                children: [
                                  // Expanded(child: Image.asset("images/mm.jpg", fit: BoxFit.cover, width: double.infinity,)),
                                  Expanded(
                                    child: BlocBuilder<MainCubit, MainAppStates>(
                                        builder: (context, state)=> context.read<MainCubit>().uploadedImageFile==null
                                            ? CustomTextFormField(
                                            controller: TextEditingController(),
                                            validator: (value){
                                              return null;
                                            },
                                            isEnabled: false,
                                            hint: 'Type here',
                                            isDescription: true,
                                            hintColor: AppColors.descriptionColor,
                                            radius: 17,
                                            context: context)
                                            : Image.file(context.read<MainCubit>().uploadedImageFile!, width: double.infinity, fit: BoxFit.cover,)
                                    ),
                                  ),
                                  verticalSpace(8),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: BlocBuilder<MainCubit, MainAppStates>(
                                      builder: (context, state) {
                                        return context.read<MainCubit>().loadWhileUpload
                                            ? const CustomLoading(alignment: AlignmentDirectional.centerEnd,)
                                            : CustomButton(
                                            text: 'Translate',
                                            height: 40,
                                            width: 129,
                                            function: ()async {
                                              if(context.read<MainCubit>().uploadedImageFile!=null){
                                                context.read<MainCubit>().uploadImageToFirestore(context);
                                              }else {
                                                CustomSnackBarHandler.showCustomSnackBar(context: context, text: 'Select an image first!');
                                              }
                                            });
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),

                  verticalSpace(21),
                  Container(
                    // Box3------------------------------------------------------------------------
                      height: 271.h,
                      constraints: BoxConstraints(
                        minHeight: 271.0.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff30271e),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.volume_up_rounded),
                                color: const Color(0xffffd700),
                              ),
                              const CustomText(
                                size: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffd700),
                                text: 'English',
                              ),
                            ],
                          ),


                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0.w,),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: 'Your translation will appear here :)',
                                    size: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.copy_rounded),
                                        color: AppColors.goldColor,
                                        iconSize: 28,
                                      ),
                                      BlocBuilder<MainCubit, MainAppStates>(
                                        buildWhen: (prev, current)=> prev is ChangeFavoriteState || current is ChangeFavoriteState,
                                        builder: (context, state) {
                                          return IconButton(
                                            onPressed: () {
                                              context.read<MainCubit>().changeFavorite();
                                            },
                                            icon: context.read<MainCubit>().inFavorite
                                                  ? const Icon(Icons.star_rounded)
                                                : const Icon(Icons.star_outline_rounded),

                                            color: AppColors.goldColor,
                                            iconSize: 28,
                                          );
                                        }
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        }
    );
  }
}
