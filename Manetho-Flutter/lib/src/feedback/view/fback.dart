import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mannetho/core/constants/constants.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:mannetho/core/theming/font_weight_helper.dart';
import 'package:mannetho/core/widgets/custom_button.dart';
import 'package:mannetho/core/widgets/custom_loading.dart';
import 'package:mannetho/core/widgets/custom_text_form_field.dart';
import 'package:mannetho/core/widgets/snack_bar.dart';
import 'package:mannetho/src/feedback/view_model/feedback_cubit.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/custom_text.dart';

class FeedbackScreen extends StatelessWidget {

  static final formKey= GlobalKey<FormState>();
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin:Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors:[
                    Color(0xff724B27),
                    Color(0xff171715)

                  ])
          ),
          child: MediaQuery.removePadding(context: context, child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 32.r,
                        )),
                    const CustomText(
                        text: 'Feedback',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        size: 25),
                  ],
                ),
              ),
              verticalSpace(10),
              //upload image--------------------------------------------------------
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          //What the button do?---------------
                          context.read<FeedbackCubit>().pickImage();
                        },
                        child: Container(
                           height: 211.h,
                          alignment: Alignment.center,
                          // padding: EdgeInsets.symmetric(vertical: 30.h, ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: const Color(0xff463322),
                            borderRadius: BorderRadius.all(Radius.circular(17.r)),
                            border: Border.all(color: const Color(0xffEEB619),),
                          ),

                          child:  BlocBuilder<FeedbackCubit, FeedbackState>(
                            builder: (context, state) {
                              return context.read<FeedbackCubit>().image!= null
                                  ? ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(17.r)),
                                  child: Image.file(context.read<FeedbackCubit>().image!, fit: BoxFit.cover, width: double.infinity,))
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(AppAssets.circle, height: 100.w, width: 100.w,),
                                      Image.asset(AppAssets.uploadImage, width: 48.w, height: 48.w,),
                                    ],
                                  ),
                                  verticalSpace(12.h),
                                  const CustomText(
                                    text: 'Upload a pic',
                                    color: Colors.white,
                                    size: 15, fontWeight: FontWeightHelper.medium,),
                                ],
                              );
                            }
                          ),

                        ),
                      ),
                      Container(height: 20),

                      CustomTextFormField(
                          controller: context.read<FeedbackCubit>().feedbackController,
                          radius: 17.r,
                          isDescription: true,
                          contentPadding: EdgeInsets.all(16.w),
                          hint: 'Type your issue',
                          validator: (String? value){
                            if(value==null || value.isEmpty) return 'Enter your problem';
                            return null;
                          },
                          context: context),


                      verticalSpace(30),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: BlocConsumer<FeedbackCubit, FeedbackState>(
                          builder: (context, state) {
                            return context.read<FeedbackCubit>().loadWhileUpload
                                ? const CustomLoading()
                                : CustomButton(text: 'Save',
                                function: (){
                              if(formKey.currentState!.validate()){
                                if(context.read<FeedbackCubit>().image!= null){
                                  context.read<FeedbackCubit>().uploadImageToFirestore(context);
                                }else {
                                  context.read<FeedbackCubit>().storeFeedback(null);
                                }
                              }
                            });
                          },
                          listener: (context, state){
                            if(state is UploadImageToFireStoreErrorState || state is StoreFeedBackErrorState){
                              CustomSnackBarHandler.showCustomSnackBar(context: context, text: AppConstants.errorMessage);
                            }else if(state is StoreFeedBackSuccessState){
                              CustomSnackBarHandler.showCustomSnackBar(context: context,state: SnackBarStates.success, text: 'Feedback sent successfully');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ))
      ),
    );
  }
}
