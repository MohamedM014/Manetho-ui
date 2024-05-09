
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theming/color_manger.dart';
import '../helpers/enums.dart';
import '../theming/font_weight_helper.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.context,
    this.hint,
    this.color = Colors.white,
    this.icon,
    this.radius = 50,
    this.height = 53,
    this.enabledBorderColor = AppColors.borderColor,
    this.hintColor = AppColors.gray,
    this.contentPadding,
    this.inputType = TextInputType.text,
    this.isDescription = false,
    this.isEnabled = true,
    this.isPassword = false,
    this.isSecured = false,
    this.onChanged,
    this.backgroundColor= const Color(0xff30271e),
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIconPressed,
    this.textType = InputType.text,
    this.withBorder = true,
    this.onTap,
    this.hintStyle
  }) : super(key: key);


  final TextEditingController controller;

  final String? Function(String?)? validator;
  final IconData ? icon;
  final IconData ? prefixIcon;
  final String ? hint;
  final Color color;
  final Color? backgroundColor;
  final bool withBorder;
  final bool isDescription;
  final bool isPassword;
  final bool isSecured;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final double radius;
  final bool isEnabled;
  final Color hintColor;
  final Color enabledBorderColor;
  final double height;
  final BuildContext context;
  final Function ? suffixIconPressed;
  final TextInputType inputType;
  final InputType textType;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled ? true : false,
      inputFormatters: textType == InputType.number
          ? [
        FilteringTextInputFormatter.allow(
          RegExp(
            r'(^\d*\.?\d*)$',
          ),
        ),
      ] : null,
      onTap: onTap,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      textAlignVertical: TextAlignVertical.bottom,
      validator: validator,
      onChanged: onChanged,
      maxLines: isDescription ? 7 : 1,
      obscureText: isSecured ? true : false,
      keyboardType: inputType,

      style: GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.gray,
      ),
      decoration: InputDecoration(
        isDense: true,
        fillColor: backgroundColor,
        filled: true,
        hintText: hint,
        hintStyle: hintStyle ?? GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: FontWeightHelper.medium,
          color: AppColors.gray,
        ),
        contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 46.w),
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, color: hintColor, size: 30.r,),
        // prefixIconConstraints: BoxConstraints(
        //     maxHeight: 30.h, minWidth: 32.w),
        suffixIcon: icon == null ? null : InkWell(
          onTap: (){
            suffixIconPressed!();
          },
          child: Icon(
            icon, color: AppColors.gray,  size: 30.r,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(radius)),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: withBorder ? enabledBorderColor : color),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: withBorder ? enabledBorderColor : color),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}