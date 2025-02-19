import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/features/entrypoint/components/app_bottom_navigation_bar.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:path_provider/path_provider.dart';

class EntryPointUi extends StatelessWidget {
  const EntryPointUi({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  static const String routeName = 'entryPointUi';


  Future<void> _deleteTemporaryFiles() async {
    try {
      final tempDir = await getTemporaryDirectory(); // Obtener directorio temporal
      if(!await tempDir.exists()){
        return;
      }
      final files = tempDir.listSync(); // Listar archivos

      for (var file in files) {
        if (file is File) {
          await file.delete(); // Eliminar archivo
        }
      }
    } catch (e) {
      print("Error al eliminar archivos temporales: $e");
    }
  }

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
        onNavTap: (index) {
          if(index != 1){
            _deleteTemporaryFiles();
          }
          navigationShell.goBranch(index);
        },
      ),
    );
  }
}