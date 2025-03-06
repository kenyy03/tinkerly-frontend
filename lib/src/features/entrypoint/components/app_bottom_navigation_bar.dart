import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/entrypoint/components/bottom_app_bar_item.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.scaffoldBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomAppBarItem(
            name: 'Home',
            iconLocation: AppIcons.home,
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray)
            ),
          ),
          BottomAppBarItem(
            name: 'Perfiles',
            iconLocation: AppIcons.profilePerson,
            isActive: currentIndex == 2,
            onTap: () => onNavTap(2),
          ),
          // const Padding(
          //   padding: EdgeInsets.all(AppDefaults.padding * 2),
          //   child: SizedBox(width: AppDefaults.margin),
          // ),
          // /* <---- We have to leave this 3rd index (2) for the cart item -----> */

          // BottomAppBarItem(
          //   name: 'Save',
          //   iconLocation: AppIcons.save,
          //   isActive: currentIndex == 3,
          //   onTap: () => onNavTap(3),
          // ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray)
            ),
          ),
          BottomAppBarItem(
            name: 'Mi Perfil',
            iconLocation: AppIcons.profile,
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
          ),
        ],
      ),
    );
  }
}
