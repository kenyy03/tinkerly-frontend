import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final ICityRepository _repository;
  AddressBloc(ICityRepository repository) : _repository = repository, super(AddressInitial()) {
    on<LoadCities>(_loadCities);
    on<NeighborhoodOnChanged>(_saveNeighborhood);
    on<DirectionsOnChanged>(_saveDirections);
    on<CityOnChanged>(_saveCity);
  }
  
  void _loadCities(LoadCities event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading());
      final result = await _repository.getCities();
      emit(CitiesObtained(cities: result)); 
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _saveNeighborhood(NeighborhoodOnChanged event, Emitter<AddressState> emit) async {
    try {
      emit(AddressFilled(address: state.address.copyWith(neighborhood:  event.neighborhood), cities: [...state.cities])); 
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _saveDirections(DirectionsOnChanged event, Emitter<AddressState> emit){
    try {
      emit(AddressFilled(address: state.address.copyWith(directions: event.directions), cities: [...state.cities]));
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _saveCity(CityOnChanged event, Emitter<AddressState> emit){
    try {
      emit(AddressFilled(address: state.address.copyWith(city: event.city), cities: [...state.cities]));
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }
}
