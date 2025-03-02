
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
      on<HourlyRateOnChanged>(_onChangeHourlyRate);
      on<ServiceFeeOnChanged>(_onChangeServiceFee);
  }

  void _userLogginFilled(LoadUserLoggin event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: [...state.ocupations],
      showAll: state.showAll,
      user: event.userLogged.copyWith(), 
      userOcupation: state.userOcupation.copyWith(),
    ));
  }
  
  void _namesChanged(NamesOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: [...state.ocupations],
      showAll: state.showAll,
      user: state.user.copyWith(names: event.names), 
      userOcupation: state.userOcupation.copyWith(),
    ));
  }

  void _lastNamesChanged(LastNamesOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: [...state.ocupations],
      showAll: state.showAll,
      user: state.user.copyWith(lastNames: event.lastNames), 
      userOcupation: state.userOcupation.copyWith(),
    ));
  }

  void _phoneChanged(PhoneOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: [...state.ocupations],
      showAll: state.showAll,
      user: state.user.copyWith(phone: event.phone), 
      userOcupation: state.userOcupation.copyWith(),
    ));
  }

  void _descriptionChanged(DescriptionOnChanged event, Emitter<MyprofileEditState> emit){
    emit(UserFilled(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: [...state.ocupations],
      showAll: state.showAll,
      user: state.user.copyWith(description: event.description), 
      userOcupation: state.userOcupation.copyWith(),
    ));
  }

  void _loadOcupations(LoadOcupations event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _ocupationRepository.getOcupations();
      emit(OcupationsObtained(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupations: response, 
        ocupationSelected: state.ocupationSelected,
        ocupationsFiltered: response,
        showAll: state.showAll,
        user: state.user, 
        userOcupation: state.userOcupation.copyWith(),
      ));
    } catch (e) {
      emit(MyprofileEditFailure(messageError: e.toString()));
    }
  }

  void _onSelectedOcupation(OcupationOnSelected event, Emitter<MyprofileEditState> emit){
    emit(OcupationSelected(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: [...state.ocupations],
      ocupationSelected: event.ocupationSelected.copyWith(), 
      ocupationsFiltered: [...state.ocupations],
      showAll: state.showAll,
      user: state.user, 
      userOcupation: state.userOcupation.copyWith(),
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
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: [...state.ocupations],
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: [...ocupationsToShow],
      showAll: state.showAll,
      user: state.user,
      userOcupation: state.userOcupation.copyWith(),
    ));
  }

  void _onAddNewOcupation(AddNewOcupation event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _ocupationRepository.createOcupations(
        newOcupations: [Ocupation(description: event.ocupation)]
      );      
      emit(OcupationAdded(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: response[0],
        ocupations: [...state.ocupations],
        ocupationSelected: state.ocupationSelected,
        ocupationsFiltered: [...state.ocupationsFiltered],
        showAll: state.showAll,
        user: state.user,
        userOcupation: state.userOcupation.copyWith(),
      ));
    } catch (e) {
      emit(MyprofileEditFailure(messageError: e.toString()));
    }
  }

  void _onLoadAbilitiesByUser(LoadAbilitiesByUser event, Emitter<MyprofileEditState> emit) async {
    try {
      final response = await _abilityRepository.getAbilitiesByUser(userId: event.userId);
      emit(AbilitiesByUserObtained(
        abilities: state.abilities,
        abilitiesByUser: response,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupations: state.ocupations,
        ocupationSelected: state.ocupationSelected,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: state.user,
        userOcupation: state.userOcupation.copyWith(),
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
          abilities: preSelectAbilities,
          abilitiesByUser: state.abilitiesByUser,
          abilitiesFiltered: preSelectAbilities,
          ocupationAdded: state.ocupationAdded,
          ocupations: state.ocupations,
          ocupationSelected: state.ocupationSelected,
          ocupationsFiltered: state.ocupationsFiltered,
          showAll: state.showAll,
          user: state.user,
          userOcupation: state.userOcupation.copyWith(),
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
      userOcupation: state.userOcupation.copyWith(),
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
    }    

    emit(AbilitiesFiltered(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: abilitiesToShow,
      ocupationAdded: state.ocupationAdded,
      ocupations: state.ocupations,
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: state.ocupationsFiltered,
      showAll: state.showAll,
      user: state.user,
      userOcupation: state.userOcupation.copyWith(),
    ));
  }

  void _onChangingAbilityToSearch(SearchAbilityOnChange event, Emitter<MyprofileEditState> emit){
    emit(AbilityToSearchChanging(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      abilitySearchChanging: event.abilityOnChanging,
      ocupationAdded: state.ocupationAdded,
      ocupations: state.ocupations,
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: state.ocupationsFiltered,
      showAll: state.showAll,
      user: state.user,
      userOcupation: state.userOcupation.copyWith(),
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
        abilities: abilitiesUpdated,
        abilitiesByUser: abilitiesByUserUpdated,
        abilitiesFiltered: abilitiesUpdated,
        ocupationAdded: state.ocupationAdded,
        ocupations: state.ocupations,
        ocupationSelected: state.ocupationSelected,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: state.user,
        userOcupation: state.userOcupation.copyWith(),
      ));

    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }    
  }

  void _onPressShowAllAbilities(ShowAllAbilitiesOnPress event, Emitter<MyprofileEditState> emit){
    emit(ShowAllAbilities(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: state.ocupations,
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: state.ocupationsFiltered,
      showAll: event.showAll,
      user: state.user,
      userOcupation: state.userOcupation.copyWith(),
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
      ocupationAdded: state.ocupationAdded,
      ocupations: state.ocupations,
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: state.ocupationsFiltered,
      showAll: state.showAll,
      user: state.user,
      userOcupation: state.userOcupation.copyWith(),
    ));
  }

  void _onAssignOcupationToUser(AssignOcupationToUserPressed event, Emitter<MyprofileEditState> emit) async {
    try {
      emit(MyprofileEditLoading(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupationSelected: state.ocupationSelected,
        ocupations: state.ocupations,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: state.user,
        userOcupation: state.userOcupation.copyWith(),
      ));
      await _ocupationRepository.assignOcupationToUser(userOcupation: event.userOcupation);
    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }
  }

  void _onInsertAbilitiesForUser(InsertAbilitiesForUserPressed event, Emitter<MyprofileEditState> emit) async {
    try {
      emit(MyprofileEditLoading(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupationSelected: state.ocupationSelected,
        ocupations: state.ocupations,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: state.user,
        userOcupation: state.userOcupation.copyWith(),
      ));
      await _abilityRepository.insertAbilitiesForUser(abilitiesForUser: event.abilitiesForUser);
    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }
  }

  void _onUpdateUser(UpdateUserSaved event, Emitter<MyprofileEditState> emit) async {
    try {
      emit(MyprofileEditLoading(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupations: state.ocupations,
        ocupationSelected: state.ocupationSelected,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: state.user,
        userOcupation: state.userOcupation.copyWith(),
      ));
      final response = await _userRepository.updateUser(user: event.user);
      emit(UserUpdated(
        abilities: state.abilities,
        abilitiesByUser: state.abilitiesByUser,
        abilitiesFiltered: state.abilitiesFiltered,
        ocupationAdded: state.ocupationAdded,
        ocupations: state.ocupations,
        ocupationSelected: state.ocupationSelected,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: response,
        userOcupation: state.userOcupation.copyWith(),
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
        ocupations: state.ocupations,
        ocupationSelected: response.ocupation,
        ocupationsFiltered: state.ocupationsFiltered,
        showAll: state.showAll,
        user: state.user,
        userOcupation: response,
      ));
    } catch (e) {
      MyprofileEditFailure(messageError: e.toString());
    }
  }

  void _onChangeHourlyRate(HourlyRateOnChanged event, Emitter<MyprofileEditState> emit){
  emit(UserOcupationFilled(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: state.ocupations,
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: state.ocupationsFiltered,
      showAll: state.showAll,
      user: state.user,
      userOcupation: state.userOcupation.copyWith(hourlyRate: event.hourlyRate),
    ));
  }

  void _onChangeServiceFee(ServiceFeeOnChanged event, Emitter<MyprofileEditState> emit){
  emit(UserOcupationFilled(
      abilities: state.abilities,
      abilitiesByUser: state.abilitiesByUser,
      abilitiesFiltered: state.abilitiesFiltered,
      ocupationAdded: state.ocupationAdded,
      ocupations: state.ocupations,
      ocupationSelected: state.ocupationSelected,
      ocupationsFiltered: state.ocupationsFiltered,
      showAll: state.showAll,
      user: state.user,
      userOcupation: state.userOcupation.copyWith(serviceFee: event.serviceFee),
    ));
  }
}
