

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theming/color_manger.dart';



class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize=14,
    this.textColor=AppColors.goldColor,
    this.icon=null ,
    this.fontWeight= FontWeight.w700

  }) : super(key: key);

  String text;
  Function onPressed;
  double fontSize;
  FontWeight? fontWeight;
  Color textColor=AppColors.goldColor;
  Widget? icon=null ;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(foregroundColor : MaterialStateProperty.all<Color>(textColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: fontWeight,
              color: textColor,
              fontSize: fontSize.sp,
            ),
          ),
          if(icon!=null)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 4.0),
              child: icon!,
            ),
        ],
      ),
      onPressed: (){
        onPressed();
      },
    );
  }
}
