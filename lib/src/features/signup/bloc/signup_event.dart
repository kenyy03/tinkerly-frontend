part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountPressed extends SignupEvent {
  const CreateAccountPressed({
    required this.names,
    required this.lastNames, 
    required this.email, 
    required this.phone, 
    required this.password, 
    required this.role,
  });
  
  final String names;
  final String lastNames;
  final String email;
  final String phone;
  final String password;
  final String role;
}

