import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mannetho/core/dependency_injection/dependency_injection.dart';
import 'package:mannetho/core/helpers/extensions.dart';
import 'package:mannetho/core/routing/routes.dart';
import 'package:mannetho/src/layout/view/home.dart';
import 'package:mannetho/src/authentication/models/user_model.dart';
import 'package:mannetho/src/authentication/view_model/signup_cubit/signup_cubit.dart';
import 'package:mannetho/src/feedback/view_model/feedback_cubit.dart';
import 'package:mannetho/src/profile/view/edit_email_screen.dart';
import 'package:mannetho/src/profile/view/profile.dart';
import '../../src/feedback/view/fback.dart';
import '../../src/splash.dart';
import '../../src/authentication/view/screens/forgot_password_screen.dart';
import '../../src/authentication/view/screens/login_screen.dart';
import '../../src/authentication/view/screens/signup_screen.dart';
import '../../src/authentication/view_model/login_cubit/login_cubit.dart';
import '../../src/profile/view_model/profile_cubit.dart';
import '../helpers/spacing.dart';
import '../theming/color_manger.dart';
import '../theming/font_weight_helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class AppRouter {
  static Route<dynamic>? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => Splash());

      case Routes.signup:
        return MaterialPageRoute(
            builder: (context) =>
                BlocProvider(
                  create: (context) => getIt<SignupCubit>(),
                  child: SignupScreen(),
                ));

      case Routes.login:
        return MaterialPageRoute(
            builder: (context) =>
                BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: const LoginScreen(),
                ));

      case Routes.feedbackScreen:
        return MaterialPageRoute(
            builder: (context) =>
                BlocProvider(
                  create: (context) => getIt<FeedbackCubit>(),
                  child: const FeedbackScreen(),
                ));

      case Routes.profile:
        return MaterialPageRoute(
            builder: (context) =>
                BlocProvider(
                  create: (context) =>
                  getIt<ProfileCubit>()
                    ..getUser(routeSettings.arguments as UserModel),
                  child: const Profile(),
                ));

      case Routes.home:
        return MaterialPageRoute(
            builder: (context) =>
                LayoutScreen());

      case Routes.editEmail:
        return MaterialPageRoute(
            builder: (context) =>
                BlocProvider.value(
                  value: getIt<ProfileCubit>(),
                  child: EditEmailScreen(),
                ));

    case Routes.forgetPassword:
    return MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen());


    //
    // case Routes.home:
    //   return MaterialPageRoute(
    //       builder: (context) => BlocProvider.value(
    //             value: getIt<MainCubit>()..getCurrentUser(context),
    //             child: UserLayoutScreen(),
    //           ));


      default:
        return undefinedRoute();
    }
  }


  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(20.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'This page is not found, go to Home Screen',
                      size: 18,
                      inCenter: true,
                      fontWeight: FontWeightHelper.semiBold,
                      color: AppColors.descriptionColor,
                    ),
                    verticalSpace(50),
                    CustomButton(
                        text: 'Go to home',
                        radius: 8.r,
                        function: () {
                          context.pushNamedAndRemoveUntil(Routes.home,
                              predicate: (Route<dynamic> route) => false);
                        }),
                  ],
                ),
              )),
        ));
  }
}
