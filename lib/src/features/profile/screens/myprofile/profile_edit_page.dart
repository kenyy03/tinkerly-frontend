import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/components/app_back_button.dart';
import 'package:mobile_frontend/src/features/common/services/stores/user_store.dart';
import 'package:mobile_frontend/src/features/profile/screens/myprofile/bloc/myprofile_edit_bloc.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({super.key});

  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _lastNamesController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ocupationController = TextEditingController();
  final UserStorage _userStorage = UserStorage();

  @override
  Widget build(BuildContext context) {
    final currentUser = _userStorage.get('user');
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Profile',
        ),
      ),
      body: BlocListener<MyprofileEditBloc, MyprofileEditState>(
        listener: (context, state) {
          if(state is OcupationsObtained){
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
            context.read<MyprofileEditBloc>().add(LoadUserLoggin(userLogged: userLogged));
            _namesController.text = userLogged.names;
            _lastNamesController.text = userLogged.lastNames;
            _phoneController.text = userLogged.phone;
            _descriptionController.text = userLogged.description;
          }
        },
        child: BlocBuilder<MyprofileEditBloc, MyprofileEditState>(
          builder: (context, state) {
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
                      onChanged: (String nombre) {
                        context
                            .read<MyprofileEditBloc>()
                            .add(NamesOnChanged(names: nombre));
                      },
                      controller: _namesController,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Last Name -----> */
                    const Text("Apellidos"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (apellidos) {
                        context
                            .read<MyprofileEditBloc>()
                            .add(LastNamesOnChanged(lastNames: apellidos));
                      },
                      controller: _lastNamesController,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Phone Number -----> */
                    const Text("Telefono"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (telefono) {
                        context
                            .read<MyprofileEditBloc>()
                            .add(PhoneOnChanged(phone: telefono));
                      },
                      controller: _phoneController,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Gender -----> */
                    const Text("Resumen sobre ti"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 2,
                      onChanged: (description) {
                        context.read<MyprofileEditBloc>().add(
                            DescriptionOnChanged(description: description));
                      },
                      controller: _descriptionController,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Birthday -----> */
                    const Text("Ocupación"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _ocupationController,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onTap: () async {
                        final Ocupation? result = await UiUtil.openBottomSheet(
                            context: context,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.8),
                            widget: _SearchOcupation());
                        _ocupationController.text = result?.description ?? '';
                      },
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Password -----> */

                    /* <---- Birthday -----> */
                    const Text("Habilidades"),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    /* <---- Submit -----> */
                    const SizedBox(height: AppDefaults.padding),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {},
                      ),
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

class _SearchOcupation extends StatelessWidget {
  const _SearchOcupation();

  @override
  Widget build(BuildContext context) {
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
                Text('Selecciona su ocupacion',
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
                vertical: AppDefaults.margin * 2),
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      context.read<MyprofileEditBloc>().add(
                        SearchOcupation(ocupation: value)
                      );
                    },
                  ),
                  SizedBox(height: AppDefaults.margin),
                  Container(
                    margin: EdgeInsets.only(bottom: AppDefaults.margin),
                    height: MediaQuery.of(context).size.height * 0.522,
                    child: SingleChildScrollView(
                      child: BlocSelector<MyprofileEditBloc, MyprofileEditState,
                          List<Ocupation>>(
                        selector: (state) {
                          return state.ocupationsFiltered;
                        },
                        builder: (context, state) {
                          return Column(
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
                                        return Card(
                                          color: state.id.isNotEmpty &&
                                                  state.id == ocupation.id
                                              ? Theme.of(context).indicatorColor
                                              : Theme.of(context).cardColor,
                                          child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<MyprofileEditBloc>()
                                                  .add(OcupationOnSelected(
                                                      ocupationSelected:
                                                          ocupation));
                                              context.pop(ocupation);
                                            },
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
                                                    textAlign: TextAlign.start,
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
