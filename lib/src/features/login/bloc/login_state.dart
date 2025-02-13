part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final User user;
  LoginState({User? user}) : user = user ?? User(
    names: '', 
    lastNames: '', 
    email: '', 
    password: '', 
    phone: ''
  );
  
  @override
  List<Object> get props => [user];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {
  final String mensaje;

  LoginLoading({this.mensaje='Cargando...', super.user});
}

final class LoginFailure extends LoginState {
  final String mensajeError;

  LoginFailure({this.mensajeError= 'Internal Server Error'});
}

final class UserLoginFilled extends LoginState {
  UserLoginFilled({super.user});
}

final class UserAutenticateSuccess extends LoginState {

  UserAutenticateSuccess({super.user}) ;
}