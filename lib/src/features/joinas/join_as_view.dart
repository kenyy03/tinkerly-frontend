import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/stores/role_store.dart';
import 'package:mobile_frontend/src/features/joinas/components/role_card.dart';
import 'package:mobile_frontend/src/features/joinas/cubit/role_radio_button_cubit.dart';
import 'package:mobile_frontend/src/features/signup/components/already_have_account.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:quickalert/quickalert.dart';

class JoinAsView extends StatelessWidget {
  const JoinAsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  final roleStore = RoleStore();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RoleRadioButtonCubit, RoleRadioButtonState>(
          builder: (context, state) {
            return Center(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppDefaults.margin),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: Text('Unete como Empleado o Profesional',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: AppDefaults.padding),
                      Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (state is RoleLoading ? 
                              Column(
                                children: [
                                  Text(state.message),
                                  SizedBox(height: AppDefaults.margin),
                                  CircularProgressIndicator()
                                ],
                              ): SizedBox.shrink()),
                            ...state.roles.map((element) {
                              return (RoleCard(
                                key: Key(element.id),
                                labelText: element.description == 'Empleador'
                                    ? 'Soy un empleador, buscando un profesional.'
                                    : 'Soy un profesional, buscando un trabajo.',
                                isActive: element.isSelected,
                                isFirstElement:
                                    element.id == state.roles.first.id,
                                onTap: () {
                                  final rolesWithValueSelected =
                                      state.roles.map((role) {
                                    if (role.isSelected) {
                                      final currenRoleSelected =
                                          role.copyWith(isSelected: false);
                                      return currenRoleSelected;
                                    }
                                    if (role.id == element.id) {
                                      final roleSelected = role.copyWith(
                                          isSelected: !role.isSelected);
                                      return roleSelected;
                                    }

                                    return role;
                                  }).toList();

                                  context
                                      .read<RoleRadioButtonCubit>()
                                      .selectRadioButton(
                                          roles: rolesWithValueSelected);
                                },
                              ));
                            })
                          ],
                        ),
                      ),
                      SizedBox(height: AppDefaults.padding),
                      Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if(state.roles.every((a) => !a.isSelected)){
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    text: 'Es obligatorio que selecciones una opción',
                                  );
                                  return;
                                }
                                roleStore.save('roles', state.roles);
                                context.pushReplacement(
                                  AppRoutes.signup.replaceFirst(
                                    ':roleId', 
                                    state.roles.firstWhere((role) => role.isSelected ).id
                                  )
                                );
                              },
                              style: ElevatedButton.styleFrom(elevation: 1),
                              child: Row(
                                children: [
                                  Text('Crear Cuenta',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.white)),
                                  SizedBox(width: AppDefaults.padding),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const AlreadyHaveAnAccount(),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
