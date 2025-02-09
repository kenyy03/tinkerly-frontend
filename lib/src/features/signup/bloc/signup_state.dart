part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class SignUpLoading extends SignupState {
  final String mensaje;

  const SignUpLoading({this.mensaje='Cargando...'});
}

final class SignUpFailure extends SignupState {
  final String mensajeError;

  const SignUpFailure({this.mensajeError= 'Internal Server Error'});
}