import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/data/infrastructure.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/entrypoint/entry_point_ui.dart';
import 'package:mobile_frontend/src/features/home/home_screen.dart';
import 'package:mobile_frontend/src/features/joinas/cubit/role_radio_button_cubit.dart';
import 'package:mobile_frontend/src/features/joinas/join_as_screen.dart';
import 'package:mobile_frontend/src/features/login/bloc/login_bloc.dart';
import 'package:mobile_frontend/src/features/login/login_screen.dart';
import 'package:mobile_frontend/src/features/profile/profile_screen.dart';
import 'package:mobile_frontend/src/features/profile/screens/directions/bloc/address_bloc.dart';
import 'package:mobile_frontend/src/features/profile/screens/directions/directions_screen.dart';
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
    GoRoute(
      name: DirectionsScreen.routeName,
      path: AppRoutes.newAddress,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => AddressBloc(
            CityRepository(dataSource: CityDataSource())
          )..add(LoadCities()),
          child: DirectionsScreen(),
        );
      },
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return EntryPointUi(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                name: HomenScreen.routeName,
                path: AppRoutes.home,
                builder: (context, state) => HomenScreen())
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: ProfileScreen.routeName,
                path: AppRoutes.profile,
                builder: (context, state) => ProfileScreen())
          ]),
        ])
  ],
);
