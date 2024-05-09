
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/widgets/custom_shimmer.dart';
import '../../../core/helpers/spacing.dart';



class FavoritesShimmer extends StatelessWidget {
  const FavoritesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      padding: EdgeInsets.all(12.w),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => const FavoriteCardShimmer(),
      separatorBuilder: (context, index) => verticalSpace(20),
      itemCount: 5,
    );
  }
}


class FavoriteCardShimmer extends StatelessWidget {
  const FavoriteCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Row(
        children: [
          CustomShimmer(
            width: 100,
            height: 100,
            radius: 12,
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CustomShimmer(
                  width: 120,
                  height: 16.h,
                  radius: 4,
                ),
                verticalSpace(10),
                CustomShimmer(
                  width: double.infinity,
                  height: 14.h,
                  radius: 4,
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomShimmer(
                      width: 120,
                      height: 18.h,
                      radius: 4,
                    ),
                    CustomShimmer(
                      width: 30,
                      height: 30,
                      radius: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}