import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/data/datasources/role_datasource.dart';
import 'package:mobile_frontend/src/data/repositories/role_repository.dart';
import 'package:mobile_frontend/src/domain/routes/app_routes.dart';
import 'package:mobile_frontend/src/features/joinas/cubit/role_radio_button_cubit.dart';
import 'package:mobile_frontend/src/features/joinas/join_as_screen.dart';
import 'package:mobile_frontend/src/features/login/login_screen.dart';
import 'package:mobile_frontend/src/features/signup/signup_screen.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      name: LoginScreen
          .routeName, // Optional, add name to your routes. Allows you navigate by name instead of path
      path: AppRoutes.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: SignUpScreen.routeName,
      path: AppRoutes.signup,
      builder: (context, state) {
        final String roleId = state.pathParameters['roleId'] ?? 'no-id';
        return SignUpScreen(roleId: roleId);
      },
    ),
    GoRoute(
      name: JoinAsScreen.routeName,
      path: AppRoutes.joinAsRole,
      builder: (context, state) => BlocProvider(
        create: (context) => RoleRaddionButtonCubit(
          RoleRepository(dataSource: RoleDatasource())
        )..getRoles(),
        child: JoinAsScreen(),
      ),
    ),
  ],
);
