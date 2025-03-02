import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/services.dart';
import 'package:mobile_frontend/src/features/profile/components/profile_list_tile.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfileMenuOptions extends StatelessWidget {
  ProfileMenuOptions({
    super.key,
  });

  final userStored = UserStorage();
  final roleStored = RoleStore();

  @override
  Widget build(BuildContext context) {
    final currentUser = userStored.get('user');
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        children: [
          ProfileListTile(
            title: 'Mi Perfil',
            icon: AppIcons.profilePerson,
            onTap: () => context.push('${AppRoutes.profile}${AppRoutes.profileEdit.replaceFirst(':userId', currentUser!.id)}'),
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Dirección',
            icon: AppIcons.homeProfile,
            onTap: () {
              context.push(
                '${AppRoutes.profile}${AppRoutes.newAddress.replaceFirst(':userId', currentUser!.id)}'
              );
            },
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Configuración',
            icon: AppIcons.profileSetting,
            onTap: () => context.push(AppRoutes.settings),
          ),
          const Divider(thickness: 0.1),
          // ProfileListTile(
          //   title: 'Payment',
          //   icon: AppIcons.profilePayment,
          //   onTap: () => context.push(AppRoutes.paymentMethod),
          // ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Logout',
            icon: AppIcons.profileLogout,
            onTap: () {
              userStored.remove('user');
              roleStored.remove('roles');
              context.pushReplacement(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}
