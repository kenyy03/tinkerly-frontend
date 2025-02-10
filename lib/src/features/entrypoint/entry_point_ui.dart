import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/features/entrypoint/components/app_bottom_navigation_bar.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class EntryPointUi extends StatelessWidget {
  const EntryPointUi({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  static const String routeName = 'entryPointUi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.scaffoldBackground,
            child: child,
          );
        },
        duration: AppDefaults.duration,
        child: navigationShell,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // onBottomNavigationTap(2);
      //   },
      //   backgroundColor: AppColors.primary,
      //   child: SvgPicture.asset(AppIcons.cart),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onNavTap: (index) =>  navigationShell.goBranch(index),
      ),
    );
  }
}