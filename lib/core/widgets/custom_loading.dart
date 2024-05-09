import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/color_manger.dart';



class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key, this.alignment= Alignment.center}) : super(key: key);
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignment,
        child: SizedBox(
            height: 40.h,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              strokeWidth: 5,
            )) //Lottie.asset('assets/lottie/loading.json', height: 40.h)
     );
  }
}
