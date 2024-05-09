import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mannetho/core/constants/constants.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:mannetho/core/helpers/spacing.dart';
import 'package:mannetho/core/theming/color_manger.dart';
import 'package:mannetho/core/widgets/custom_text.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

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
            child: ListView(
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
                          text: 'About Us',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          size: 25),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 20.h),
                  child: Column(
                    children: [
                      SvgPicture.asset(AppAssets.about),


                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const CustomText(
                              text: 'Who We Are',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              size: 20),
                          horizontalSpace(6),
                          Container(
                            height: 2.8,
                            width: 41.w,
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),

                      verticalSpace(20),

                      const CustomText(
                          text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard ....',
                          color: Color(0xffE4E4E4),
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          size: 13),

                      verticalSpace(50),

                      const CustomText(
                          text: 'What personal information we collect  ــــــــــ',
                          color: Colors.white,
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          size: 20),


                      verticalSpace(10),
                      const CustomText(
                          text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard ....',
                          color: Color(0xffE4E4E4),
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          size: 13),

                      verticalSpace(30),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const CustomText(
                              text: 'Contact Us',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              size: 20),
                          horizontalSpace(6),
                          Container(
                            height: 2.8,
                            width: 41.w,
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),

                      verticalSpace(20),

                      Row(
                        children: [
                          InkWell(
                            onTap: (){},
                            child: CircleAvatar(
                              backgroundColor: AppColors.lightGray,
                              radius: 27.w,
                              child: Image.asset(AppAssets.google, height: 32.h, width: 32.h,),
                            ),
                          ),
                          horizontalSpace(20),
                          InkWell(
                            onTap: (){},
                            child: CircleAvatar(
                              backgroundColor: AppColors.lightGray,
                              radius: 27.w,
                              child: Image.asset(AppAssets.facebook, height: 32.h, width: 32.h,),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
