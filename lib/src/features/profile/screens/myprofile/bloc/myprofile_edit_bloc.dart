
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
part 'myprofile_edit_event.dart';
part 'myprofile_edit_state.dart';

class MyprofileEditBloc extends Bloc<MyprofileEditEvent, MyprofileEditState> {
  final IOcupationRepository _ocupationRepository;
  final IAbilityRepository _abilityRepository;
  final IAuthRepository _userRepository;

  MyprofileEditBloc({ 
    required IOcupationRepository ocupationRepository, 
    required IAbilityRepository abilityRepository,
    required IAuthRepository userRepository, 
  }) : 
    _ocupationRepository = ocupationRepository, 
    _abilityRepository = abilityRepository,
    _userRepository = userRepository,
    super(MyprofileEditInitial()) {
      on<LoadUserLoggin>(_userLogginFilled);
      on<NamesOnChanged>(_namesChanged);
      on<LastNamesOnChanged>(_lastNamesChanged);
      on<PhoneOnChanged>(_phoneChanged);
      on<DescriptionOnChanged>(_descriptionChanged);
      on<LoadOcupations>(_loadOcupations);
      on<OcupationOnSelected>(_onSelectedOcupation);
      on<SearchOcupation>(_onFilteredOcupation);
      on<AddNewOcupation>(_onAddNewOcupation);
      on<LoadAbilitiesByUser>(_onLoadAbilitiesByUser);
      on<LoadAbilities>(_onLoadAbilities);
      on<SelectAbilities>(_onSelectAbilities);
      on<SearchAbility>(_onSearchAbility);
      on<SearchAbilityOnChange>(_onChangingAbilityToSearch);
      on<AddAditionalAbility>(_onAddNewAbility);
      on<ShowAllAbilitiesOnPress>(_onPressShowAllAbilities);
      on<DeleteUserAbilityById>(_onDeleteUserAbilityById);
      on<AssignOcupationToUserPressed>(_onAssignOcupationToUser);
      on<InsertAbilitiesForUserPressed>(_onInsertAbilitiesForUser);
      on<UpdateUserSaved>(_onUpdateUser);
      on<LoadOcupationByUser>(_onLoadOcupationByUserId);
  }

  void _userLogginFilled(LoadUserLoggin event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: event.userLogged.copyWith(), 
      ocupationSelected: state.ocupationSelected,
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationAdded: state.ocupationAdded,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitiesByUser: state.abilitiesByUser,
      showAll: state.showAll,
    ));
  }
  
  void _namesChanged(NamesOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(names: event.names), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationAdded: state.ocupationAdded,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitiesByUser: state.abilitiesByUser,
      showAll: state.showAll,
    ));
  }

  void _lastNamesChanged(LastNamesOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(lastNames: event.lastNames), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationAdded: state.ocupationAdded,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitiesByUser: state.abilitiesByUser,
      showAll: state.showAll,
    ));
  }

  void _phoneChanged(PhoneOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(phone: event.phone), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationAdded: state.ocupationAdded,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitiesByUser: state.abilitiesByUser,
      showAll: state.showAll,
    ));
  }

  void _descriptionChanged(DescriptionOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      user: state.user.copyWith(description: event.description), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationAdded: state.ocupationAdded,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitiesByUser: state.abilitiesByUser,
      showAll: state.showAll,
    ));
  }

  void _loadOcupations(LoadOcupations event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _ocupationRepository.getOcupations();
      emit(OcupationsObtained(
        ocupations: response, 
        ocupationsFiltered: response,
        ocupationSelected: state.ocupationSelected,
        ocupationAdded: state.ocupationAdded,
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        user: state.user, 
        showAll: state.showAll,
      ));
    } catch (e) {
      emit(MyprofileEditFailure(messageError: e.toString()));
    }
  }

  void _onSelectedOcupation(OcupationOnSelected event, Emitter<MyprofileEditState> emit){
    emit(OcupationSelected(
      user: state.user, 
      ocupationSelected: event.ocupationSelected.copyWith(), 
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...state.ocupations],
      ocupationAdded: state.ocupationAdded,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitiesByUser: state.abilitiesByUser,
      showAll: state.showAll,
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
      user: state.user,
      ocupationSelected: state.ocupationSelected,
      ocupations: [...state.ocupations],
      ocupationsFiltered: [...ocupationsToShow],
      ocupationAdded: state.ocupationAdded,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitiesByUser: state.abilitiesByUser,
      showAll: state.showAll,
    ));
  }

  void _onAddNewOcupation(AddNewOcupation event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _ocupationRepository.createOcupations(
        newOcupations: [Ocupation(description: event.ocupation)]
      );      
      emit(OcupationAdded(
        user: state.user,
        ocupationSelected: state.ocupationSelected,
        ocupations: [...state.ocupations],
        ocupationsFiltered: [...state.ocupationsFiltered],
        ocupationAdded: response[0],
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        showAll: state.showAll,
      ));
    } catch (e) {
      emit(MyprofileEditFailure(messageError: e.toString()));
    }
  }

  void _onLoadAbilitiesByUser(LoadAbilitiesByUser event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _abilityRepository.getAbilitiesByUser(userId: event.userId);
      emit(AbilitiesByUserObtained(
        abilitiesByUser: response,
        abilities: state.abilities,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupationSelected: state.ocupationSelected,
        ocupations: state.ocupations,
        ocupationsFiltered: state.ocupationsFiltered,
        user: state.user,
        showAll: state.showAll,
      ));
    } catch (e) {
      emit(MyprofileEditFailure(messageError: e.toString()));
    }
  }

  void _onLoadAbilities(LoadAbilities event, Emitter<MyprofileEditState> emit) async {
    try {
      await Future.delayed(Duration(milliseconds: 100), () async {
        final response = await _abilityRepository.getAllAbilities();
        final preSelectAbilities = response.map((ability){
            if(state.abilitiesByUser.any((a) => a.ability.id == ability.id)){
              ability = ability.copyWith(isSelected: true);
              return ability;
            }
            return ability;
          }).toList();

        emit(AbilitiesObtained(
          abilitiesByUser: state.abilitiesByUser,
          abilities: preSelectAbilities,
          abilitiesFiltered: preSelectAbilities,
          ocupationAdded: state.ocupationAdded,
          ocupationSelected: state.ocupationSelected,
          ocupations: state.ocupations,
          ocupationsFiltered: state.ocupationsFiltered,
          user: state.user,
          showAll: state.showAll,
        ));
      },);
    } catch (e) {
      emit(MyprofileEditFailure(messageError: e.toString()));
    }
  }

  void _onSelectAbilities(SelectAbilities event, Emitter<MyprofileEditState> emit) async {
    final abilitiesWithSelected = state.abilities.map((e){
      if(event.abilitiesSelected.any((a) => a.id == e.id)){
        return e.copyWith(isSelected: true);
      }
      return e.copyWith(isSelected: false);
    }).toList();
    emit(AbilitiesSelected(
      abilities: abilitiesWithSelected,
      abilitiesByUser: event.abilitiesSelected.map((ability){
        return UserAbility(ability: ability, userId: event.userId);
      }).toList(),
      abilitiesFiltered: abilitiesWithSelected,
      ocupationAdded: state.ocupationAdded,
      ocupationSelected: state.ocupationSelected,
      ocupations: state.ocupations,
      ocupationsFiltered: state.ocupationsFiltered,
      user: state.user,
      showAll: state.showAll,
    ));
  }

  void _onSearchAbility(SearchAbility event, Emitter<MyprofileEditState> emit){
    List<Ability> abilitiesToShow = [];
    if(event.abilityToSearch.isEmpty){
      abilitiesToShow = [...state.abilities];
    }else{
      abilitiesToShow = state.abilities
        .where((ability){
          return ability.description.toLowerCase().contains(event.abilityToSearch.toLowerCase());
        })
        .toList();

      // if(abilitiesToShow.isEmpty){
      //   abilitiesToShow = [...state.abilities, Ability(description: event.abilityToSearch, isSelected: true, id: AppUtil.generateSimpleId())];
      // }
    }    

    emit(AbilitiesFiltered(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: abilitiesToShow,
      ocupationAdded: state.ocupationAdded,
      ocupationSelected: state.ocupationSelected,
      ocupations: state.ocupations,
      ocupationsFiltered: state.ocupationsFiltered,
      user: state.user,
      showAll: state.showAll,
    ));
  }

  void _onChangingAbilityToSearch(SearchAbilityOnChange event, Emitter<MyprofileEditState> emit){
    emit(AbilityToSearchChanging(
      abilitySearchChanging: event.abilityOnChanging,
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupationSelected: state.ocupationSelected,
      ocupations: state.ocupations,
      ocupationsFiltered: state.ocupationsFiltered,
      user: state.user,
      showAll: state.showAll,
    ));
  }
  
  void _onAddNewAbility(AddAditionalAbility event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _abilityRepository.insertAbilities(
        abilities: [Ability(description: event.abilityDescription)]
      );
      
      final abilitiesUpdated = [...state.abilities, ...response.map((e) => e.copyWith(isSelected: true))];
      final abilitiesByUserUpdated = [
        ...state.abilitiesByUser, 
        ...response.map((e) => UserAbility(
          id: e.id, 
          userId: event.userId,
          ability: Ability(
            id: e.id, 
            description: e.description, 
            isSelected: true
          )
        ))
      ];

      emit(AbilitiesObtained(
        abilitiesByUser: abilitiesByUserUpdated,
        abilities: abilitiesUpdated,
        abilitiesFiltered: abilitiesUpdated,
        ocupationAdded: state.ocupationAdded,
        ocupationSelected: state.ocupationSelected,
        ocupations: state.ocupations,
        ocupationsFiltered: state.ocupationsFiltered,
        user: state.user,
        showAll: state.showAll,
      ));

    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }    
  }

  void _onPressShowAllAbilities(ShowAllAbilitiesOnPress event, Emitter<MyprofileEditState> emit){
    emit(ShowAllAbilities(
      showAll: event.showAll,
      abilitiesByUser: state.abilitiesByUser,
      abilities: state.abilities,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupationSelected: state.ocupationSelected,
      ocupations: state.ocupations,
      ocupationsFiltered: state.ocupationsFiltered,
      user: state.user,
    ));
    
  }

  void _onDeleteUserAbilityById(DeleteUserAbilityById event, Emitter<MyprofileEditState> emit){
    final userAbilities = state.abilitiesByUser.where((e) => e.ability.id != event.id).toList();
    final abilities = state.abilities.map((a) {
      if(a.id == event.id){
        return a.copyWith(isSelected: false);
      }
      return a;
    }).toList();

    emit(AbilitiesByUserObtained(
      abilities: abilities,
      abilitiesByUser: userAbilities,
      abilitiesFiltered: abilities,
      ocupations: state.ocupations,
      ocupationsFiltered: state.ocupationsFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupationSelected: state.ocupationSelected,
      user: state.user,
      showAll: state.showAll,
    ));
  }

  void _onAssignOcupationToUser(AssignOcupationToUserPressed event, Emitter<MyprofileEditState> emit) async {
    try {
      await _ocupationRepository.assignOcupationToUser(userOcupation: event.userOcupation);
    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }
  }

  void _onInsertAbilitiesForUser(InsertAbilitiesForUserPressed event, Emitter<MyprofileEditState> emit) async {
    try {
      await _abilityRepository.insertAbilitiesForUser(abilitiesForUser: event.abilitiesForUser);
    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }
  }

  void _onUpdateUser(UpdateUserSaved event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _userRepository.updateUser(user: event.user);
      emit(UserUpdated(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupationSelected: state.ocupationSelected,
        ocupations: state.ocupations,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: response,
      ));
    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }
  }

  void _onLoadOcupationByUserId(LoadOcupationByUser event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _ocupationRepository.getOcupationByUserId(userId: event.userId);
      emit(OcupationSelected(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupationSelected: response,
        ocupations: state.ocupations,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: state.user,
      ));
    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }
  }
}
