
import 'package:get_it/get_it.dart';
import 'package:mannetho/src/favorites/view_model/favorites_cubit.dart';
import '../../src/authentication/view_model/login_cubit/login_cubit.dart';
import '../../src/authentication/view_model/signup_cubit/signup_cubit.dart';
import '../../src/feedback/view_model/feedback_cubit.dart';
import '../../src/history/view_model/history_cubit.dart';
import '../../src/layout/view_model/main_cubit.dart';
import '../../src/profile/view_model/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> initGetIt()async {


  // sign up cubit
  getIt.registerFactory<SignupCubit>(() => SignupCubit());


  // Login cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit());

  getIt.registerFactory<FeedbackCubit>(() => FeedbackCubit());
  getIt.registerFactory<HistoryCubit>(() => HistoryCubit());
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit());
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit());


  // User Home cubit
  getIt.registerLazySingleton<MainCubit>(() => MainCubit());



}
