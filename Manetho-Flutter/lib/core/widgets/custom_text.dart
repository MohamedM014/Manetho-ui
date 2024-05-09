
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key,
    required this.text,
    required this.size,
    this.fontWeight,
    this.color,
    this.maxLines,
    this.textOverflow,
    this.inCenter= false,
  }) : super(key: key);

  final String text;
  final double size;
  final Color? color;
  final FontWeight? fontWeight;
  final bool inCenter;
  final int? maxLines;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: inCenter? TextAlign.center : TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: size.sp,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
