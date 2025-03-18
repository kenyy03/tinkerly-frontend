import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/components/app_back_button.dart';
import 'package:mobile_frontend/src/features/common/services/stores/user_store.dart';
import 'package:mobile_frontend/src/features/profilemenu/screens/myprofile/bloc/myprofile_edit_bloc.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({super.key});

  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _lastNamesController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ocupationController = TextEditingController();
  final TextEditingController _hourlyRateController = TextEditingController();
  final TextEditingController _serviceFeeController = TextEditingController();
  final UserStorage _userStorage = UserStorage();

  @override
  Widget build(BuildContext context) {
    final currentUser = _userStorage.get('user');
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Editar mi perfil',
        ),
      ),
      body: BlocListener<MyprofileEditBloc, MyprofileEditState>(
        listener: (context, state) {
          if (state is OcupationsObtained) {
            final userLogged = User(
              names: currentUser?.names ?? '',
              lastNames: currentUser?.lastNames ?? '',
              email: currentUser?.email ?? '',
              password: '',
              phone: currentUser?.phone ?? '',
              description: currentUser?.description ?? '',
              id: currentUser?.id ?? '',
              role: currentUser!.role.copyWith(),
              imageProfile: currentUser.imageProfile.copyWith(),
            );
            context
                .read<MyprofileEditBloc>()
                .add(LoadUserLoggin(userLogged: userLogged));
            _namesController.text =
                state.user.names.isEmpty ? userLogged.names : state.user.names;
            _lastNamesController.text = state.user.lastNames.isEmpty
                ? userLogged.lastNames
                : state.user.lastNames;
            _phoneController.text =
                state.user.phone.isEmpty ? userLogged.phone : state.user.phone;
            _descriptionController.text = state.user.description.isEmpty
                ? userLogged.description
                : state.user.description;
            _ocupationController.text = state.ocupationAdded.description.isEmpty
                ? state.ocupationSelected.description
                : state.ocupationAdded.description;
          }

          if(state is OcupationSelected){
            _ocupationController.text = state.ocupationSelected.description;
            _hourlyRateController.text = state.userOcupation.hourlyRate.toString();
            _serviceFeeController.text = state.userOcupation.serviceFee.toString();
          }
        },
        child: BlocBuilder<MyprofileEditBloc, MyprofileEditState>(
          builder: (context, state) {
            List<UserAbility> getMyAbilities(){
              if(state.showAll){
                return [...state.abilitiesByUser];
              }
              
              return state.abilitiesByUser.length <= 5 ? [...state.abilitiesByUser] : state.abilitiesByUser.take(5).toList();
            }

            final myAbilities = getMyAbilities();
            
            onChangedNames(String nombre) {
              context
                  .read<MyprofileEditBloc>()
                  .add(NamesOnChanged(names: nombre));
            }
            onChangedDescription(String description) {
              context.read<MyprofileEditBloc>().add(
                  DescriptionOnChanged(description: description));
            }
            onChangedLastNames(apellidos) {
              context
                  .read<MyprofileEditBloc>()
                  .add(LastNamesOnChanged(lastNames: apellidos));
            }
            onChangedPhone(telefono) {
              context
                  .read<MyprofileEditBloc>()
                  .add(PhoneOnChanged(phone: telefono));
            }
            onTapSearchOcupation() async {
              final Ocupation? result = await UiUtil.openBottomSheet(
                  context: context,
                  constraints: BoxConstraints(
                      maxHeight:
                          MediaQuery.of(context).size.height * 0.8),
                  widget: _SearchOcupation());
              _ocupationController.text = result?.description ?? '';
            }
            onPressedShowAllAbilities() {
              context.read<MyprofileEditBloc>().add(ShowAllAbilitiesOnPress(showAll: true));
            }
            onPressedAddAbilitiesBottomSheet() async {
              await UiUtil.openBottomSheet(
                  context: context,
                  constraints: BoxConstraints(
                      maxHeight:
                          MediaQuery.of(context).size.height * 0.8),
                  widget: _AddAbilities(userId: currentUser!.id));
            }
            onPressedSaveMyProfileChanges() {
              context.read<MyprofileEditBloc>().add(
                UpdateUserSaved(user: state.user)
              );
              context.read<MyprofileEditBloc>().add(
                InsertAbilitiesForUserPressed(abilitiesForUser: state.abilitiesByUser)
              );
              context.read<MyprofileEditBloc>().add(
                AssignOcupationToUserPressed(
                  userOcupation: state.userOcupation.copyWith(
                    userId: currentUser?.id ?? '',
                    ocupation: state.ocupationAdded.id.isEmpty
                      ? state.ocupationSelected
                      : state.ocupationAdded, 
                ))
              );
            }
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(AppDefaults.padding),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                  vertical: AppDefaults.padding * 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* <----  First Name -----> */
                    const Text("Nombres"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: onChangedNames,
                      controller: _namesController,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Last Name -----> */
                    const Text("Apellidos"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: onChangedLastNames,
                      controller: _lastNamesController,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Phone Number -----> */
                    const Text("Telefono"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: onChangedPhone,
                      controller: _phoneController,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- About you -----> */
                    const Text("Resumen sobre ti"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      onChanged: onChangedDescription,
                      controller: _descriptionController,
                      enableSuggestions: false,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Ocupation -----> */
                    const Text("Ocupación"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _ocupationController,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onTap: onTapSearchOcupation,
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    /* <---- values -----> */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            children: [
                              const Text("Pago minimo por hora"),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _hourlyRateController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  context.read<MyprofileEditBloc>()
                                    .add(HourlyRateOnChanged(hourlyRate: double.tryParse(value) ?? 0.0));
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            children: [
                              const Text("Pago minimo por servicio"),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _serviceFeeController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  context.read<MyprofileEditBloc>()
                                    .add(ServiceFeeOnChanged(serviceFee: double.tryParse(value) ?? 0.0));
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    /* <---- Password -----> */

                    /* <---- Abilities -----> */
                    const Text("Habilidades"),
                    const SizedBox(height: 8),
                    state.abilitiesByUser.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: AppDefaults.margin),
                            child: Column(
                              children: [
                                ...myAbilities.map((e) {
                                  onPressedDeleteUserAbility() {
                                            context.read<MyprofileEditBloc>().add(
                                              DeleteUserAbilityById(id: e.ability.id)
                                            );
                                          }
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(e.ability.description,
                                            overflow:
                                                TextOverflow.ellipsis),
                                        titleTextStyle: Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle,
                                        leading: IconButton(
                                          onPressed: onPressedDeleteUserAbility,
                                          icon: Icon(
                                            Icons.close_outlined,
                                            size:
                                                AppDefaults.margin * 1.3,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.1,
                                      )
                                    ],
                                  );
                                })
                              ],
                            ))
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: AppDefaults.margin),
                            child: Text('No hay habilidades para mostrar.')),
                    SizedBox(height: AppDefaults.margin),
                    state.abilitiesByUser.length > 5 && !(state.showAll) 
                        ? TextButton.icon(
                            onPressed: onPressedShowAllAbilities,
                            label: Text(
                                'Mostrar ${state.abilitiesByUser.length - myAbilities.length} mas'),
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            iconAlignment: IconAlignment.end,
                          )
                        : SizedBox.shrink(),
                    OutlinedButton(
                        style: Theme.of(context)
                            .outlinedButtonTheme
                            .style!
                            .copyWith(
                                padding: WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: AppDefaults.padding))),
                        onPressed: onPressedAddAbilitiesBottomSheet,
                        child: Text('Agregar habilidad')),
                    // TextFormField(
                    //   keyboardType: TextInputType.visiblePassword,
                    //   textInputAction: TextInputAction.next,
                    //   obscureText: true,
                    // ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Submit -----> */
                    const SizedBox(height: AppDefaults.padding),
                    state is! MyprofileEditLoading ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onPressedSaveMyProfileChanges,
                        child: const Text('Save'),
                      ),
                    ) : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.message),
                                CircularProgressIndicator()
                              ],
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddAbilities extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String userId;

  _AddAbilities({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyprofileEditBloc, MyprofileEditState>(
      listener: (context, state) {
        if (state is AbilityToSearchChanging) {
          _controller.text = state.abilitySearchChanging;
        }
        if (state is AbilitiesSelected) {
          _controller.text = '';
        }
      },
      child: BlocBuilder<MyprofileEditBloc, MyprofileEditState>(
        builder: (context, state) {
          onChangedSearchAbility(value) {
            context
                .read<MyprofileEditBloc>()
                .add(SearchAbility(abilityToSearch: value));
            context.read<MyprofileEditBloc>().add(
                SearchAbilityOnChange(abilityOnChanging: value));
          }
          return SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(AppDefaults.margin),
                padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Selecciona tus habilidades',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context).hoverColor),
                        onPressed: () => context.pop(),
                        icon: Icon(Icons.close))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppDefaults.margin,
                  vertical: AppDefaults.margin,
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: onChangedSearchAbility,
                        enableSuggestions: false,
                      ),
                      SizedBox(height: AppDefaults.margin),
                      Container(
                        margin: EdgeInsets.only(bottom: AppDefaults.margin),
                        height: MediaQuery.of(context).size.height * 0.522,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...state.abilitiesFiltered.map((ability) {
                                return Column(
                                  children: [
                                    _CardItem(
                                      userId: userId,
                                      ability: ability,
                                      abilities: state.abilities,
                                      isAditionalAbility: false,
                                    ),
                                    SizedBox(height: AppDefaults.margin)
                                  ],
                                );
                              }),
                              state.abilitiesFiltered.isEmpty
                                  ? _CardItem(
                                      userId: userId,
                                      ability: Ability(
                                          id: AppUtil.generateSimpleId(),
                                          description: _controller.text),
                                      abilities: state.abilities,
                                      isAditionalAbility: true,
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
        },
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.userId,
    required this.ability,
    required this.abilities,
    this.isAditionalAbility = false,
  });

  final String userId;
  final Ability ability;
  final List<Ability> abilities;
  final bool isAditionalAbility;

  @override
  Widget build(BuildContext context) {
    onChangedSelectAbility(value) {
      final abilitiesSelected = abilities.map((abilityToSelect) {
        if (ability.id == abilityToSelect.id) {
          return ability.copyWith(isSelected: value);
        }
        return abilityToSelect;
      }).toList();

      if (isAditionalAbility) {
        if (!abilitiesSelected.any((a) => a.id == ability.id)) {
          // abilitiesSelected
          //     .add(ability.copyWith(isSelected: value));
          context.read<MyprofileEditBloc>().add(
              AddAditionalAbility(
                  abilityDescription: ability.description,
                  id: ability.id,
                  userId: userId));
        }
      }

      context.read<MyprofileEditBloc>().add(
        SelectAbilities(
          abilitiesSelected: abilitiesSelected.where((e) => e.isSelected).toList(),
          userId: userId
        )
      );
    }
    return Card(
      child: Container(
        padding: EdgeInsets.all(AppDefaults.padding),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ability.description,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Checkbox(
                  value: ability.isSelected,
                  onChanged: onChangedSelectAbility,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SearchOcupation extends StatelessWidget {
  _SearchOcupation();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyprofileEditBloc, MyprofileEditState>(
      listener: (context, state) {
        if (state is OcupationAdded) {
          context.read<MyprofileEditBloc>().add(LoadOcupations());
          context.pop(state.ocupationAdded);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(AppDefaults.margin),
              padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Selecciona su ocupacion',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).hoverColor),
                      onPressed: (){ 
                        context
                            .read<MyprofileEditBloc>()
                            .add(OcupationOnSelected(
                                ocupationSelected:
                                    Ocupation(description: '')));
                        context.pop();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: AppDefaults.margin,
                  vertical: AppDefaults.margin * 2),
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: BlocSelector<MyprofileEditBloc, MyprofileEditState,
                    List<Ocupation>>(
                  selector: (state) {
                    return state.ocupationsFiltered;
                  },
                  builder: (context, state) {
                    onPressedAddNewOcupation() {
                      context.read<MyprofileEditBloc>().add(
                          AddNewOcupation(
                              ocupation: _controller.text));
                    }
                    onChangedSearchOcupation(value) {
                      context
                          .read<MyprofileEditBloc>()
                          .add(SearchOcupation(ocupation: value));
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                              suffixIcon: state.isEmpty
                                  ? IconButton(
                                      onPressed: onPressedAddNewOcupation,
                                      icon: Icon(Icons.add_circle_outline,
                                          color: AppColors.primary))
                                  : null),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: onChangedSearchOcupation,
                          enableSuggestions: true,
                        ),
                        SizedBox(height: AppDefaults.margin),
                        Container(
                          margin: EdgeInsets.only(bottom: AppDefaults.margin),
                          height: MediaQuery.of(context).size.height * 0.522,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...state.map((ocupation) {
                                  return Column(
                                    children: [
                                      BlocSelector<MyprofileEditBloc,
                                          MyprofileEditState, Ocupation>(
                                        selector: (state) {
                                          return state.ocupationSelected;
                                        },
                                        builder: (context, state) {
                                          onTapSaveOcupatonSelected() {
                                            context
                                                .read<MyprofileEditBloc>()
                                                .add(OcupationOnSelected(
                                                    ocupationSelected:
                                                        ocupation));
                                            context.pop(ocupation);
                                          }
                                          return Card(
                                            color: state.id.isNotEmpty &&
                                                    state.id == ocupation.id
                                                ? Theme.of(context)
                                                    .indicatorColor
                                                : Theme.of(context).cardColor,
                                            child: InkWell(
                                              onTap: onTapSaveOcupatonSelected,
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    AppDefaults.padding),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      ocupation.description,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: AppDefaults.margin)
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
