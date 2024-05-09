import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import '../helpers/spacing.dart';
import '../theming/color_manger.dart';
import '../theming/font_weight_helper.dart';
import 'custom_button.dart';

void showCustomDialog(
        {required BuildContext context,
        required String title,
        required String text,
        required String buttonText,
        required Function function}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
              content: Container(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xff724B27), Color(0xff171715)])),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeightHelper.medium,
                        color: Colors.white,
                      ),
                    ),
                    verticalSpace(20),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                                text: 'Back',
                                color: Colors.white,
                                withBorder: true,
                                radius: 6,
                                textColor: const Color(0xff171715),
                                height: 38,
                                function: () {
                                  context.pop();
                                })),
                        horizontalSpace(10),
                        Expanded(
                            child: CustomButton(
                                text: buttonText,
                                radius: 6,
                                height: 38,
                                function: () {
                                  function();
                                })),
                      ],
                    ),
                  ],
                ),
              ),
            ));
