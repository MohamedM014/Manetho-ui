

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/constants.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.image,
    this.defaultImage,
    this.width= double.infinity,
    this.height,
    this.radius,
    this.defaultImageFit= BoxFit.cover,
  }) : super(key: key);
  final String image;
  final String? defaultImage;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit defaultImageFit;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius??12.r),
      child: ConditionalBuilder(
        condition: imageType(image)!= 'svg',
        builder: (context) {
          return CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset(
              defaultImage?? AppAssets.logo,
              width: width,
              fit: defaultImageFit,),
            errorWidget: (context, url, error) => Image.asset(
              AppAssets.logo,
              width: width,
              fit: defaultImageFit,),
          );
        },
        fallback: (context)=> SvgPicture.network(
          image,
          height: height,
          width: width,
          fit: defaultImageFit,
          placeholderBuilder: (context,) => SvgPicture.asset(
            defaultImage??AppAssets.logoSvg,
            width: width,
            fit: defaultImageFit,),
        ),
      ),
    );
  }

  /// Get image type (svg , png, jpg, ...)
  String imageType(String path)=> path.split('.').last;
}