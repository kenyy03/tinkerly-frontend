part of 'myprofile_edit_bloc.dart';

sealed class MyprofileEditState extends Equatable {
  MyprofileEditState({ 
    User? user, 
    this.ocupations = const [], 
    this.ocupationsFiltered = const[],
    Ocupation? ocupationSelected, 
    Ocupation? ocupationAdded,
    this.abilities = const [],
    this.abilitiesFiltered = const [],
    this.abilitiesByUser = const [],
    this.showAll = false,
  }) 
    : ocupationSelected = ocupationSelected ?? Ocupation(description: ''),
      ocupationAdded = ocupationAdded ?? Ocupation(description: ''),
      user = user ?? User(
        names: '', 
        lastNames: '', 
        email: '', 
        password: '', 
        phone: '',
      );
  final User user;
  final List<Ocupation> ocupations;
  final List<Ocupation> ocupationsFiltered;
  final Ocupation ocupationSelected;
  final Ocupation ocupationAdded;
  final List<Ability> abilities;
  final List<Ability> abilitiesFiltered;
  final List<UserAbility> abilitiesByUser;
  final bool showAll;
  
  @override
  List<Object> get props => [
    user, 
    ocupations, 
    ocupationsFiltered,
    ocupationSelected, 
    ocupationAdded, 
    abilities,
    abilitiesFiltered,
    abilitiesByUser,
    showAll
  ];
}

final class MyprofileEditInitial extends MyprofileEditState {}

final class MyprofileEditFailure extends MyprofileEditState {
  MyprofileEditFailure({this.messageError = 'Internal Server Error'});

  final String messageError;
}

final class MyprofileEditLoading extends MyprofileEditState {
  final String message;
  MyprofileEditLoading({ 
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected,
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
    this.message='Cargando...', 
  });
}

final class OcupationsObtained extends MyprofileEditState {
  OcupationsObtained({ 
    super.ocupations, 
    super.user, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class UserFilled extends MyprofileEditState {
  UserFilled({
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered,
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class OcupationSelected extends MyprofileEditState {
  OcupationSelected({
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered,
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class OcupationsFiltered extends MyprofileEditState {
  OcupationsFiltered({
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered,
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class OcupationAdded extends MyprofileEditState {
  OcupationAdded({
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered,
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class AbilitiesObtained extends MyprofileEditState {
  AbilitiesObtained({ 
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class AbilitiesByUserObtained extends MyprofileEditState {
  AbilitiesByUserObtained({ 
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class AbilitiesSelected extends MyprofileEditState {
  AbilitiesSelected({ 
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class AbilitiesFiltered extends MyprofileEditState {
  AbilitiesFiltered({ 
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser,
    super.showAll,
  });
}

final class AbilityToSearchChanging extends MyprofileEditState {
  final String abilitySearchChanging;
  AbilityToSearchChanging({ 
    required this.abilitySearchChanging,
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser, 
    super.showAll,
  });
}

final class ShowAllAbilities extends MyprofileEditState {
  ShowAllAbilities({ 
    super.showAll,
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser, 
  });
}

final class OcupationAssignedToUser extends MyprofileEditState {
  OcupationAssignedToUser({ 
    super.showAll,
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser, 
  });
}

final class UserUpdated extends MyprofileEditState {
  UserUpdated({ 
    super.showAll,
    super.user, 
    super.ocupations, 
    super.ocupationsFiltered, 
    super.ocupationSelected, 
    super.ocupationAdded,
    super.abilities,
    super.abilitiesFiltered,
    super.abilitiesByUser, 
  });
}