import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mannetho/core/constants/constants.dart';
import 'package:mannetho/core/dependency_injection/dependency_injection.dart';
import 'package:mannetho/core/helpers/spacing.dart';
import 'package:mannetho/core/theming/color_manger.dart';
import 'package:mannetho/core/widgets/custom_text_button.dart';
import 'package:mannetho/src/favorites/models/translation_model.dart';
import 'package:mannetho/src/history/view_model/history_cubit.dart';

import '../../../core/paginate_firestore_package/paginate_firestore.dart';
import '../../../core/theming/font_weight_helper.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/empty_screen.dart';

class TranslationModel2 {
  String? text;
  String translation;
  String? imagePath;

  TranslationModel2({ this.text, this.imagePath, required this.translation});
}


class History extends StatelessWidget {
  History({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HistoryCubit>(),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: const Color(0xff171715),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          title: const CustomText(
            text: "History",
            size: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          actions: [
            BlocBuilder<HistoryCubit ,HistoryState>(
              builder: (context, state) {
                return CustomTextButton(text: 'Clear All',
                    fontSize: 18,
                    onPressed: ()async {
                      await context.read<HistoryCubit>().deleteAllHistory();

                  //     showCustomDialog(
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
          child: BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              return PaginateFirestore(
                onLoaded: (_) => const CircularProgressIndicator(),
                onError: (_) => const EmptyScreen(text: AppConstants.errorMessage),
                onEmpty: const EmptyScreen(text: 'History is empty'),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                //item builder type is compulsory.
                itemBuilder: (context, documentSnapshots, index) {
                  TranslationModel historyItem = TranslationModel.fromJson(
                      documentSnapshots[index].data() as Map<String, dynamic>);
                  return TranslatedCard(translationModel: historyItem,);
                },
                query: context.read<HistoryCubit>().historyQuery,
                //Change types accordingly
                itemBuilderType: PaginateBuilderType.listView,
                separator: verticalSpace(22),
                itemsPerPage: 10,
                // to fetch real-time data
                isLive: true,
              );
            }
          ),
        ),
      ),
    );
  }
}


class TranslatedCard extends StatelessWidget {
  const TranslatedCard({Key? key, required this.translationModel})
      : super(key: key);
  final TranslationModel translationModel;

  @override
  Widget build(BuildContext context) {
    return Slidable(

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          horizontalSpace(50),
          SlidableAction(
            onPressed: (context) {
              context.read<HistoryCubit>().deleteHistoryItem(
                  translationModel.uid);
            },
            padding: EdgeInsets.symmetric(horizontal: 10.w,),
            backgroundColor: AppColors.goldColor,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline_rounded,
            borderRadius: BorderRadius.circular(17.r),
            // label: 'Save',
          ),
          horizontalSpace(70),
        ],
      ),
      child: Stack(
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
                      'En',
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
                  padding: EdgeInsets.symmetric(
                      vertical: 18.0.h, horizontal: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'En',
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
              )
            ],
          )
        ],
      ),
    );
  }
}


// class CustomClippPath extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size){
//     double width= size.width;
//     double height= size.height;
//
//     final path= Path();
//
//
//     path.moveTo(0,0);
//     path.lineTo(width*0.32,0);
//     path.quadraticBezierTo(((width*0.32)+(width*0.5050000))/2,60,width*0.5050000,0); /// center first two values
//     path.lineTo(width,0);
//     path.lineTo(width,height);
//     path.lineTo(width*0.5050000,height);
//     path.quadraticBezierTo(((width*0.32)+(width*0.5050000))/2,height-60,width*0.32,height);
//     path.lineTo(0,height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }