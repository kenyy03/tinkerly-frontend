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
    UserOcupation? userOcupation,
  }) 
    : ocupationSelected = ocupationSelected ?? Ocupation(description: ''),
      ocupationAdded = ocupationAdded ?? Ocupation(description: ''),
      userOcupation = userOcupation ?? UserOcupation(),
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
  final UserOcupation userOcupation;
  
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
    showAll,
    userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
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
    super.userOcupation,
  });
}

final class UserOcupationFilled extends MyprofileEditState {
  UserOcupationFilled({ 
    super.abilities,
    super.abilitiesByUser, 
    super.abilitiesFiltered,
    super.ocupationAdded,
    super.ocupations, 
    super.ocupationSelected, 
    super.ocupationsFiltered, 
    super.showAll,
    super.user, 
    super.userOcupation,
  });
}