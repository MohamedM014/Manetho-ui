

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/custom_shimmer.dart';

class LoadAllUserDataShimmer extends StatelessWidget {
  const LoadAllUserDataShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Padding(
        padding: EdgeInsets.all(6.0.w),
        child: Container(
          constraints: BoxConstraints(maxHeight: 170.h),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomShimmer(
                width: 70,
                height: 70,
                radius: 150,
              ),
              CustomShimmer(
                width: 120,
                height: 14,
                radius: 6,
              ),
              CustomShimmer(
                width: double.infinity,
                height: 12,
                radius: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoadUserImageShimmer extends StatelessWidget {
  const LoadUserImageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Padding(
        padding: EdgeInsets.all(6.0.w),
        child: CustomShimmer(
          width: double.infinity,
          height: double.infinity,
          radius: 50,
        ),
      ),
    );
  }
}


class LoadUserDataShimmer extends StatelessWidget {
  const LoadUserDataShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CustomShimmer(
            width: 120,
            height: 14.h,
            radius: 4,
          ),
          verticalSpace(10),
          CustomShimmer(
            width: double.infinity,
            height: 12.h,
            radius: 4,
          ),
        ],
      ),
    );
  }
}