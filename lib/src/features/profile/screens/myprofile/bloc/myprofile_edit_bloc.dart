import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'myprofile_edit_event.dart';
part 'myprofile_edit_state.dart';

class MyprofileEditBloc extends Bloc<MyprofileEditEvent, MyprofileEditState> {
  final IOcupationRepository _ocupationRepository;
  MyprofileEditBloc({ required IOcupationRepository ocupationRepository }) : 
    _ocupationRepository = ocupationRepository, 
    super(MyprofileEditInitial()) {
      on<LoadUserLoggin>(_userLogginFilled);
      on<NamesOnChanged>(_namesChanged);
      on<LastNamesOnChanged>(_lastNamesChanged);
      on<PhoneOnChanged>(_phoneChanged);
      on<DescriptionOnChanged>(_descriptionChanged);
      on<LoadOcupations>(_loadOcupations);
      on<OcupationOnSelected>(_onSelectedOcupation);
      on<SearchOcupation>(_onFilteredOcupation);
  }

  void _userLogginFilled(LoadUserLoggin event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: event.userLogged.copyWith(), 
      ocupationSelected: state.ocupationSelected,
      ocupations: state.ocupations
    ));
  }
  
  void _namesChanged(NamesOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(names: event.names), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected
    ));
  }

  void _lastNamesChanged(LastNamesOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(lastNames: event.lastNames), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected
    ));
  }

  void _phoneChanged(PhoneOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(phone: event.phone), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected
    ));
  }

  void _descriptionChanged(DescriptionOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(description: event.description), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected
    ));
  }

  void _loadOcupations(LoadOcupations event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _ocupationRepository.getOcupations();
      emit(OcupationsObtained(
        ocupations: response, 
        ocupationsFiltered: response,
        user: state.user, 
        ocupationSelected: state.ocupationSelected
      ));
    } catch (e) {
      emit(MyprofileEditFailure(messageError: e.toString()));
    }
  }

  void _onSelectedOcupation(OcupationOnSelected event, Emitter<MyprofileEditState> emit){
    emit(OcupationSelected(
      ocupationSelected: event.ocupationSelected.copyWith(), 
      user: state.user, 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations]
    ));
  }

  void _onFilteredOcupation(SearchOcupation event, Emitter<MyprofileEditState> emit){
    List<Ocupation> ocupationsToShow = [];
    if(event.ocupation.isEmpty){
      ocupationsToShow = [...state.ocupations];
    }else{
      ocupationsToShow = state.ocupations
        .where((ocupation){
          return ocupation.description.toLowerCase().contains(event.ocupation.toLowerCase());
        })
        .toList();
    }
    emit(OcupationsFiltered(
      ocupationSelected: state.ocupationSelected,
      user: state.user,
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...ocupationsToShow]
    ));
  }
}
