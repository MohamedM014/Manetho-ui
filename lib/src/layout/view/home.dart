
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mannetho/src/layout/view_model/main_cubit.dart';
import '../../../core/constants/constants.dart';
import 'drawer_screen.dart';



class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin:Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors:[
                Color(0xffE98E40),
                Color(0xff151616)
              ])
      ),
      child: const ZoomDrawer(
        angle: 0,
        mainScreenScale: 0.1,
        menuScreen: DrawerScreen(),
        mainScreen: MainScreen(),
        clipMainScreen: true,
        borderRadius: 24.0,
        showShadow: false,
        duration: Duration(milliseconds: 400),
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final NavigationKey = GlobalKey<CurvedNavigationBarState>();
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async =>false,
      child: BlocBuilder<MainCubit, MainAppStates>(
        builder: (context, state) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              //navigation---------------------------------------------------------------------------
              bottomNavigationBar: CurvedNavigationBar(
                // key: NavigationKey,
                animationDuration: const Duration(milliseconds: 400),
                index: context.read<MainCubit>().bottomNavBarIndex,
                onTap: (index) {
                  context.read<MainCubit>().changeBottomNavBarIndex(index);
                },
                backgroundColor: const Color(0xff6a4626),
                buttonBackgroundColor: Colors.white70,
                color: Colors.white10,
                // color: ,
                height: 65,
                items: [
                  SvgPicture.asset(AppAssets.star, color: context.read<MainCubit>().bottomNavBarIndex==0 ? Colors.black : Colors.white,),
                  SvgPicture.asset(AppAssets.gallery, color: context.read<MainCubit>().bottomNavBarIndex==1 ? Colors.black : Colors.white,),
                  SvgPicture.asset(AppAssets.home, color: context.read<MainCubit>().bottomNavBarIndex==2 ? Colors.black : Colors.white,),
                  SvgPicture.asset(AppAssets.camera, color: context.read<MainCubit>().bottomNavBarIndex==3 ? Colors.black : Colors.white,),
                  SvgPicture.asset(AppAssets.history, color: context.read<MainCubit>().bottomNavBarIndex==4 ? Colors.black : Colors.white,),
                ],
              ),

              body: context.read<MainCubit>().screens[context.read<MainCubit>().bottomNavBarIndex]);
        }
      ),
    );
  }
}