
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:mannetho/core/widgets/custom_image.dart';
import 'package:mannetho/src/about_us/view/aboutus_screen.dart';
import 'package:mannetho/src/layout/view_model/main_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/color_manger.dart';
import '../../../core/widgets/custom_dialog.dart';
import '../../../core/widgets/custom_text.dart';
import 'load_user_shimmer.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            BlocBuilder<MainCubit, MainAppStates>(
                builder: (context, state) {
                  return context.read<MainCubit>().loadWhileGetUser
                      ? const LoadAllUserDataShimmer()
                      :  UserAccountsDrawerHeader(
                      accountName: CustomText(
                          text: context.read<MainCubit>().currentUser.name??'',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          size: 20),
                      accountEmail: CustomText(
                          text: context.read<MainCubit>().currentUser.email??'',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          size: 16),
                      currentAccountPicture: Container(
                        height: double.infinity,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.goldColor, width: 1.5)
                        ),
                        child: CustomImage(image: context.read<MainCubit>().currentUser.image??'',
                          radius: 150,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      )
                  );
                }
            ),
            ListTile(
              leading: const Icon(
                Icons.person_3_outlined,
                color: Colors.white,
              ),
              title: const CustomText(
                text: "Profile",
                size: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              onTap: () {
                context.pushNamed(Routes.profile, arguments: context.read<MainCubit>().currentUser);
              },
            ),


            ListTile(
              leading: const Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              title: const CustomText(
                text: "About Us",
                size: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Aboutus(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.feedback_outlined,
                color: Colors.white,
              ),
              title: const CustomText(
                text: "Feedback",
                size: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              onTap: () {
                context.pushNamed(Routes.feedbackScreen);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              title: const CustomText(
                text: "LogOut",
                size: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              onTap: () {
                showCustomDialog(
                    context: context,
                    title: 'LogOut',
                    text: 'Are you sure to log out?',
                    buttonText: 'LogOut',
                    function: (){
                      FirebaseAuth.instance.signOut().then((value)async {
                        await GoogleSignIn().signOut();
                        SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
                        sharedPreferences.remove('uid');
                        context.pushNamedAndRemoveUntil(Routes.login,
                            predicate: (route) => false);
                      });
                    });
              },
            )
          ],
        ));
  }
}