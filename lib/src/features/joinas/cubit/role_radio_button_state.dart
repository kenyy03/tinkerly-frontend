part of 'role_radio_button_cubit.dart';

sealed class RoleRadioButtonState extends Equatable {
  const RoleRadioButtonState({required this.roles});
  final List<Role> roles;

  RoleRadioButtonState copyWith({roles}) ;
  @override
  List<Object> get props => [roles];
}

final class RoleRadioButtonInitial extends RoleRadioButtonState {
  const RoleRadioButtonInitial() : super(roles: const []);
  
  @override
  RoleRadioButtonState copyWith({roles}) {
    throw UnimplementedError();
  }
}

final class RoleRadioButtonSelected extends RoleRadioButtonState {
  const RoleRadioButtonSelected({required super.roles});

  @override
  RoleRadioButtonState copyWith({roles}) 
    => RoleRadioButtonSelected(
      roles: roles ?? this.roles
    );
}

final class RoleLoading extends RoleRadioButtonState {
  const RoleLoading({required super.roles, this.message='Cargando...'});
  final String message;

  @override
  RoleRadioButtonState copyWith({roles}) {
    throw UnimplementedError();
  }

}