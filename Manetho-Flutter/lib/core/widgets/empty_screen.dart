import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/color_manger.dart';
import '../theming/font_weight_helper.dart';
import 'custom_text.dart';


class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomText(
          text: text,
          size: 18.sp,
          inCenter: true,
          fontWeight: FontWeightHelper.bold,
          color: AppColors.descriptionColor.withOpacity(0.6),
        ),
    );
  }
}