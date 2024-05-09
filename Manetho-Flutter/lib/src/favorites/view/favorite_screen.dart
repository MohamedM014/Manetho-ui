import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mannetho/core/dependency_injection/dependency_injection.dart';
import 'package:mannetho/core/helpers/spacing.dart';
import 'package:mannetho/core/theming/color_manger.dart';
import 'package:mannetho/core/widgets/custom_image.dart';
import 'package:mannetho/src/layout/view_model/main_cubit.dart';
import '../../../core/theming/font_weight_helper.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../../../core/widgets/empty_screen.dart';
import '../models/translation_model.dart';
import '../view_model/favorites_cubit.dart';
import 'favorites_shimmer.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavoritesCubit>()..getFavorites(
        ids: context.read<MainCubit>().currentUser.favoritesIds
      ),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: const Color(0xff171715),
          elevation: 0,
          title: const CustomText(
            text: "Favorites",
            size: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          actions: [
            BlocBuilder<FavoritesCubit ,FavoritesState>(
                builder: (context, state) {
                  return CustomTextButton(text: 'Clear All',
                      fontSize: 18,
                      onPressed: ()async {
                        await context.read<FavoritesCubit>().deleteAllFavorites(context);

                        //     showCustomDialog(/// TODO : add dialog to fav and history
                        //     context: context,
                        //     title: 'Delete All History',
                        //     text: 'Are you sure you want to delete all history?',
                        //     buttonText: 'Delete', function: ()async {
                        //   await context.read<HistoryCubit>().deleteAllHistory();
                        //   context.pop();
                        // });
                      });
                }
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xff724B27),
                    Color(0xff171715)

                  ])
          ),
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              return context.read<FavoritesCubit>().loadWhileGetFav
                  ? const FavoritesShimmer()
                  : context.read<FavoritesCubit>().favorites.isEmpty
                  ? const EmptyScreen(text: 'Favorites is empty')
                  : ListView.separated(
                itemCount: context.read<FavoritesCubit>().favorites.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                //item builder type is compulsory.
                itemBuilder: (context,index) => FavoriteCard(translationModel: context.read<FavoritesCubit>().favorites[index],),
                separatorBuilder: (context,index) => verticalSpace(20),
              );
            }
          ),


        ),
      ),
    );
  }
}


class FavoriteCard extends StatelessWidget {
  const FavoriteCard({Key? key, required this.translationModel,})
      : super(key: key);
  final TranslationModel translationModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
            'assets/images/card4.svg'
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              margin: EdgeInsets.only(left: 17.w, top: 18.h, bottom: 18.h),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r)
              ),
              child: translationModel.imagePath == null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    translationModel.translateFrom,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeightHelper.medium,
                      color: AppColors.goldColor,
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    translationModel.text ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.medium,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
                  : CustomImage(image: translationModel.imagePath!),
            ),

            horizontalSpace(35),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 18.0.h, bottom: 18.h, left: 17.w, right: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      translationModel.translateTo,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeightHelper.medium,
                        color: AppColors.goldColor,
                      ),
                    ),
                    verticalSpace(8),
                    Text(
                      translationModel.translation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.medium,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Positioned(
            bottom: 6.h,
            right: 0.w,
            child: IconButton(
              icon: const Icon(Icons.star_rounded, color: AppColors.goldColor,),
              onPressed: () {
                context.read<FavoritesCubit>().deleteFromFavorites(
                    itemId: translationModel.uid,
                  context: context
                );
              },
            )
        )
      ],
    );
  }
}