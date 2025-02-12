part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountPressed extends SignupEvent {
  // const CreateAccountPressed({required this.user});
  const CreateAccountPressed();
  
  // final User user;
}

class NamesOnChanged extends SignupEvent {
  final String names;

  const NamesOnChanged({required this.names});
}

class LastNamesOnChanged extends SignupEvent {
  final String lastNames;

  const LastNamesOnChanged({required this.lastNames});
}

class EmailOnChanged extends SignupEvent {
  final String email;

  const EmailOnChanged({required this.email});
}

class PhoneOnChanged extends SignupEvent {
  final String phone;

  const PhoneOnChanged({required this.phone});
}

class PasswordOnChanged extends SignupEvent {
  final String password;

  const PasswordOnChanged({required this.password});
}

