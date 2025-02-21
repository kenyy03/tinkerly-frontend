part of 'myprofile_edit_bloc.dart';

sealed class MyprofileEditState extends Equatable {
  MyprofileEditState({ 
    User? user, 
    this.ocupations = const [], 
    Ocupation? ocupationSelected, 
    this.ocupationsFiltered = const[]
  }) 
    : ocupationSelected = ocupationSelected ?? Ocupation(description: ''),
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
  
  @override
  List<Object> get props => [user, ocupations, ocupationSelected, ocupationsFiltered];
}

final class MyprofileEditInitial extends MyprofileEditState {}

final class MyprofileEditFailure extends MyprofileEditState {
  MyprofileEditFailure({this.messageError = 'Internal Server Error'});

  final String messageError;
}

final class MyprofileEditLoading extends MyprofileEditState {
  final String message;
  MyprofileEditLoading({ 
    super.ocupations, 
    super.user, 
    super.ocupationSelected,
    super.ocupationsFiltered, 
    this.message='Cargando...' 
  });
}

final class OcupationsObtained extends MyprofileEditState {
  OcupationsObtained({ 
    super.ocupations, 
    super.user, 
    super.ocupationSelected, 
    super.ocupationsFiltered 
  });
}

final class UserFilled extends MyprofileEditState {
  UserFilled({
    super.user, 
    super.ocupations, 
    super.ocupationSelected, 
    super.ocupationsFiltered
  });
}

final class OcupationSelected extends MyprofileEditState {
  OcupationSelected({
    super.user, 
    super.ocupations, 
    super.ocupationSelected, 
    super.ocupationsFiltered
  });
}

final class OcupationsFiltered extends MyprofileEditState {
  OcupationsFiltered({
    super.user, 
    super.ocupations, 
    super.ocupationSelected, 
    super.ocupationsFiltered
  });
}