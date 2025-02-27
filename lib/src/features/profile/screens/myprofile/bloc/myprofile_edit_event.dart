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

final class AddNewOcupation extends MyprofileEditEvent {
  final String ocupation;

  const AddNewOcupation({required this.ocupation});
}

final class LoadAbilitiesByUser extends MyprofileEditEvent {
  final String userId;

  const LoadAbilitiesByUser({required this.userId});
}

final class LoadOcupationByUser extends MyprofileEditEvent {
  final String userId;

  const LoadOcupationByUser({required this.userId});
}

final class LoadAbilities extends MyprofileEditEvent {}

final class SelectAbilities extends MyprofileEditEvent {
  final List<Ability> abilitiesSelected;
  final String userId;

  const SelectAbilities({required this.abilitiesSelected, required this.userId});
}

final class SearchAbility extends MyprofileEditEvent {
  final String abilityToSearch;

  const SearchAbility({required this.abilityToSearch});
}

final class AddAditionalAbility extends MyprofileEditEvent {
  final String abilityDescription;
  final String id;
  final String userId;

  const AddAditionalAbility({
    required this.abilityDescription, 
    required this.id,
    required this.userId,
  });
}

final class SearchAbilityOnChange extends MyprofileEditEvent {
  final String abilityOnChanging;

  const SearchAbilityOnChange({required this.abilityOnChanging});
}

final class ShowAllAbilitiesOnPress extends MyprofileEditEvent {
  final bool showAll;

  const ShowAllAbilitiesOnPress({required this.showAll});
}

final class DeleteUserAbilityById extends MyprofileEditEvent {
  final String id;

  const DeleteUserAbilityById({required this.id});
}

final class AssignOcupationToUserPressed extends MyprofileEditEvent {
  final UserOcupation userOcupation;

  const AssignOcupationToUserPressed({required this.userOcupation});
}

final class InsertAbilitiesForUserPressed extends MyprofileEditEvent {
  final List<UserAbility> abilitiesForUser;

  const InsertAbilitiesForUserPressed({required this.abilitiesForUser});
}

final class UpdateUserSaved extends MyprofileEditEvent {
  final User user;

  const UpdateUserSaved({required this.user});
}