
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/spacing.dart';
import '../theming/font_weight_helper.dart';


enum SnackBarStates{success, error, warning}

class CustomSnackBarHandler{


  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showCustomSnackBar({
    required BuildContext context,
    SnackBarStates state= SnackBarStates.error,
    required String text,
  })
  => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content: Container(
          margin: EdgeInsets.all(10.w),
          padding: EdgeInsetsDirectional.only(bottom: 10.h, top: 10.h, start: 30.w, end: 10.w),
          decoration: BoxDecoration(
              color: _getSnackBarColor(state),
              borderRadius: BorderRadius.circular(12.r)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Icon(_getSnackBarIcon(state), color: Colors.white.withOpacity(0.9),),
                  horizontalSpace(6.w),
                  Text(
                    _getTitle(state),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  ),

                  const Spacer(),
                  InkWell(
                      onTap: (){
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      child: const Icon(Icons.close_rounded, color: Colors.white,))
                ],
              ),
              verticalSpace(8),

              Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ],
          ),
        ),
      )
  );


  static Color _getSnackBarColor(SnackBarStates state){
    switch(state){

      case SnackBarStates.success:
        return Colors.green;
      case SnackBarStates.error:
        return Colors.redAccent;
      case SnackBarStates.warning:
        return Colors.orangeAccent;
    }
  }

  static IconData _getSnackBarIcon(SnackBarStates state){
    switch(state){

      case SnackBarStates.success:
        return Icons.check_circle_outline_sharp;
      case SnackBarStates.error:
        return Icons.error_rounded;
      case SnackBarStates.warning:
        return Icons.warning_rounded;
    }
  }


  static String _getTitle(SnackBarStates state){
    switch(state){
      case SnackBarStates.success:
        return 'Success';
      case SnackBarStates.error:
        return 'Error';
      case SnackBarStates.warning:
        return 'Warning';
    }
  }
}