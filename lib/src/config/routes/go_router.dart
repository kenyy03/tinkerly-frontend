import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/data/infrastructure.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/entrypoint/entry_point_ui.dart';
import 'package:mobile_frontend/src/features/home/cubit/home_cubit.dart';
import 'package:mobile_frontend/src/features/home/home_screen.dart';
import 'package:mobile_frontend/src/features/joinas/cubit/role_radio_button_cubit.dart';
import 'package:mobile_frontend/src/features/joinas/join_as_screen.dart';
import 'package:mobile_frontend/src/features/login/bloc/login_bloc.dart';
import 'package:mobile_frontend/src/features/login/login_screen.dart';
import 'package:mobile_frontend/src/features/professionalitem/cubit/professional_cubit.dart';
import 'package:mobile_frontend/src/features/profilemenu/cubits/imageprofilecubit/image_picker_profile_cubit.dart';
import 'package:mobile_frontend/src/features/profilemenu/cubits/switchcubit/switch_cubit.dart';
import 'package:mobile_frontend/src/features/profilemenu/profile_screen.dart';
import 'package:mobile_frontend/src/features/profilemenu/screens/directions/bloc/address_bloc.dart';
import 'package:mobile_frontend/src/features/profilemenu/screens/directions/directions_screen.dart';
import 'package:mobile_frontend/src/features/profilemenu/screens/myprofile/bloc/myprofile_edit_bloc.dart';
import 'package:mobile_frontend/src/features/profilemenu/screens/myprofile/profile_edit_screen.dart';
import 'package:mobile_frontend/src/features/professionalitem/professional_item_screen.dart';
import 'package:mobile_frontend/src/features/signup/bloc/signup_bloc.dart';
import 'package:mobile_frontend/src/features/signup/signup_screen.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      name: LoginScreen
          .routeName, // Optional, add name to your routes. Allows you navigate by name instead of path
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            LoginBloc(AuthRepository(datasource: AuthDataSource())),
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      name: SignUpScreen.routeName,
      path: AppRoutes.signup,
      builder: (context, state) {
        final String roleId = state.pathParameters['roleId'] ?? 'no-id';
        return BlocProvider(
          create: (context) =>
              SignupBloc(AuthRepository(datasource: AuthDataSource())),
          child: SignUpScreen(roleId: roleId),
        );
      },
    ),
    GoRoute(
      name: JoinAsScreen.routeName,
      path: AppRoutes.joinAsRole,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            RoleRadioButtonCubit(RoleRepository(dataSource: RoleDatasource()))
              ..getRoles(),
        child: JoinAsScreen(),
      ),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => ImagePickerProfileCubit(
                    repository: AuthRepository(datasource: AuthDataSource())),
              ),
              BlocProvider(
                create: (context) => AddressBloc(
                  CityRepository(dataSource: CityDataSource()),
                  AddressRepository(dataSource: AddressDataSource())
                ),
              ),
              BlocProvider(
                create: (context) => MyprofileEditBloc(
                  ocupationRepository: OcupationRepository(dataSource: OcupationDataSource()),
                  abilityRepository: AbilityRepository(dataSource: AbilityDataSource()),
                  userRepository: AuthRepository(datasource: AuthDataSource()),
                )
              ),
              BlocProvider(
                create: (context) => HomeCubit(
                  authRepository: AuthRepository(datasource: AuthDataSource()) 
                )
              ),
              BlocProvider(
                create: (context) => SwitchCubit(
                  repository: AuthRepository(datasource: AuthDataSource())
                ),
              ),
              BlocProvider(
                create: (context) => ProfessionalCubit(
                  authRepository: AuthRepository(datasource: AuthDataSource())
                ),
              ),
            ],
            child: EntryPointUi(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              name: HomenScreen.routeName,
              path: AppRoutes.home,
              builder: (context, state){
                context.read<HomeCubit>().getUsersHome(); 
                return HomenScreen();
              }
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: ProfileScreen.routeName,
                path: AppRoutes.profile,
                builder: (context, state) => ProfileScreen(),
                routes: [
                  GoRoute(
                    name: ProfileEditScreen.routeName,
                    path: AppRoutes.profileEdit,
                    builder: (context, state) {
                      final String userId = state.pathParameters['userId'] ?? 'no-id';
                      context.read<MyprofileEditBloc>().add(LoadOcupations());
                      context.read<MyprofileEditBloc>().add(LoadAbilitiesByUser(userId: userId));
                      context.read<MyprofileEditBloc>().add(LoadOcupationByUser(userId: userId));
                      context.read<MyprofileEditBloc>().add(LoadAbilities());
                      return ProfileEditScreen();
                    },
                  ),
                  GoRoute(
                    name: DirectionsScreen.routeName,
                    path: AppRoutes.newAddress,
                    builder: (context, state) {
                      final String userId =
                          state.pathParameters['userId'] ?? 'no-id';
                      context.read<AddressBloc>().add(LoadCities());
                      context.read<AddressBloc>().add(GetAddressByUserId(userId: userId));
                      return DirectionsScreen(currentUserId: userId);
                    },
                  ),
                ]),
          ]),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileItems,
                name: ProfessionalItemScreen.routeName,
                builder: (context, state) {
                  context.read<ProfessionalCubit>().getPublicUsers();
                  return ProfessionalItemScreen();
                },
              ),
            ] 
          )
        ])
  ],
);
