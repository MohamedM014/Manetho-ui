import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theming/color_manger.dart';



class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    required this.function,
    this.color =AppColors.goldColor,
    this.iconColor =Colors.black,
    this.textColor = Colors.black,
    this.withBorder=false,
    this.radius=50,
    this.height=54,
    this.fontSize=17,
    this.width=double.infinity,
    this.icon,
    this.elevation=0,

  }) : super(key: key);

  String text;
  Function function;
  Color color =AppColors.primaryColor;
  Color iconColor =Colors.black;
  Color textColor = Colors.black;
  bool withBorder=false;
  double radius=50;
  double height=52;
  double fontSize=18;
  double width=double.infinity;
  IconData? icon;
  double elevation=0.0;


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side:withBorder ? const BorderSide(width: 2.0,color: AppColors.primaryColor) : BorderSide.none,
      ),
      padding: EdgeInsets.zero,
      color: color,
      height:height.h,
      minWidth:width.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon!=null)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(icon, color: iconColor.withOpacity(0.7),),
            ),
          Text(
            text,
            style:GoogleFonts.roboto(
              color: textColor,
              fontSize: fontSize.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      onPressed: (){
        function();
      },
    );
  }
}
