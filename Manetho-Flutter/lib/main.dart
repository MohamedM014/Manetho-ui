import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mannetho/src/layout/view_model/main_cubit.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainCubit>()..getCurrentUser(context),
      child: ScreenUtilInit(
        designSize: const Size(428, 899),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashRoute,
              onGenerateRoute: AppRouter.onGeneratedRoute,
              home: child,
            ),
        // child: child,
      ),
    );
  }

}