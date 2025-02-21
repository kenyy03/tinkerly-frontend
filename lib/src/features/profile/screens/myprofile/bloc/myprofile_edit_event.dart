part of 'myprofile_edit_bloc.dart';

sealed class MyprofileEditEvent extends Equatable {
  const MyprofileEditEvent();

  @override
  List<Object> get props => [];
}

final class NamesOnChanged extends MyprofileEditEvent {
  final String names;

  const NamesOnChanged({required this.names});
}

final class LastNamesOnChanged extends MyprofileEditEvent {
  final String lastNames;

  const LastNamesOnChanged({required this.lastNames});
}

final class PhoneOnChanged extends MyprofileEditEvent {
  final String phone;

  const PhoneOnChanged({required this.phone});
}

final class DescriptionOnChanged extends MyprofileEditEvent {
  final String description;

  const DescriptionOnChanged({required this.description});
}

final class LoadOcupations extends MyprofileEditEvent {}

final class OcupationOnSelected extends MyprofileEditEvent {
  final Ocupation ocupationSelected;

  const OcupationOnSelected({required this.ocupationSelected});
}

final class LoadUserLoggin extends MyprofileEditEvent {
  final User userLogged;

  const LoadUserLoggin({required this.userLogged}); 
}

final class SearchOcupation extends MyprofileEditEvent {
  final String ocupation;

  const SearchOcupation({required this.ocupation});
}