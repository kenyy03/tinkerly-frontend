import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/services.dart';
import 'package:mobile_frontend/src/features/profilemenu/components/profile_list_tile.dart';
import 'package:mobile_frontend/src/features/profilemenu/cubits/switchcubit/switch_cubit.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfileMenuOptions extends StatelessWidget {
  ProfileMenuOptions({
    super.key,
  });

  final userStored = UserStorage();
  final roleStored = RoleStore();

  @override
  Widget build(BuildContext context) {
    User? currentUser = userStored.get('user');
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
            onTap: () => context.push(
                '${AppRoutes.profile}${AppRoutes.profileEdit.replaceFirst(':userId', currentUser!.id)}'),
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Dirección',
            icon: AppIcons.homeProfile,
            onTap: () {
              context.push(
                  '${AppRoutes.profile}${AppRoutes.newAddress.replaceFirst(':userId', currentUser!.id)}');
            },
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Configuración',
            icon: AppIcons.profileSetting,
            onTap: () => context.push(AppRoutes.settings),
          ),
          const Divider(thickness: 0.1),
          BlocBuilder<SwitchCubit, SwitchState>(
            builder: (context, state) {
              currentUser = currentUser!.copyWith(isPublicProfile: state.isActive);
              return ProfileListTile(
                onTap: () {
                  context.read<SwitchCubit>()
                    .publishProfile(
                      isPublicProfile: !currentUser!.isPublicProfile, 
                      userId: currentUser!.id
                    );
                },
                icon: AppIcons.publishProfile,
                title: 'Publicar perfil',
                renderWidget: true,
                child: Switch(
                  value: currentUser!.isPublicProfile,
                  onChanged: (bool active) {
                    context.read<SwitchCubit>()
                      .publishProfile(
                        isPublicProfile: active, 
                        userId: currentUser!.id
                      );
                  },
                ),
              );
            },
          ),
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
