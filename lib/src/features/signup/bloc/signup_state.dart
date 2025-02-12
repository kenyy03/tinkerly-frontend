part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  SignupState({User? user}) : user = user ?? User(names: '', lastNames: '', email: '', password: '', phone: '');
  final User user;
  
  @override
  List<Object> get props => [user];
}

final class SignupInitial extends SignupState {}

final class SignUpLoading extends SignupState {
  final String mensaje;

  SignUpLoading({this.mensaje='Cargando...'});
}

final class SignUpFailure extends SignupState {
  final String mensajeError;

  SignUpFailure({this.mensajeError= 'Internal Server Error'});
}

final class UserFilled extends SignupState {
  UserFilled({super.user});
}

final class UserCreatedSuccess extends SignupState {

  UserCreatedSuccess({super.user}) ;
}