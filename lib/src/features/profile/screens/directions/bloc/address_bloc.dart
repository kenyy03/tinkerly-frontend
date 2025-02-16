import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/stores/user_store.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final ICityRepository _cityRepository;
  final IAddressRepository _addressRepository;
  AddressBloc(ICityRepository cityRepository, IAddressRepository addressRepository) 
    : _cityRepository = cityRepository, 
      _addressRepository = addressRepository,
      super(AddressInitial()) {
    on<LoadCities>(_loadCities);
    on<NeighborhoodOnChanged>(_saveNeighborhood);
    on<DirectionsOnChanged>(_saveDirections);
    on<CityOnChanged>(_saveCity);
    on<GetAddressByUserId>(_getAddressByUserId);
    on<SaveAddress>(_saveAddress);
  }
  
  void _loadCities(LoadCities event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading());
      final result = await _cityRepository.getCities();
      emit(CitiesObtained(cities: result)); 
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _saveNeighborhood(NeighborhoodOnChanged event, Emitter<AddressState> emit) async {
    try {
      emit(AddressFilled(
        address: state.address.copyWith(neighborhood:  event.neighborhood), 
        cities: [...state.cities]
      )); 
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _saveDirections(DirectionsOnChanged event, Emitter<AddressState> emit){
    try {
      emit(AddressFilled(
        address: state.address.copyWith(directions: event.directions), 
        cities: [...state.cities]
      ));
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _saveCity(CityOnChanged event, Emitter<AddressState> emit){
    try {
      emit(AddressFilled(
        address: state.address.copyWith(city: event.city), 
        cities: [...state.cities]
      ));
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _getAddressByUserId(GetAddressByUserId event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading(message: 'Obteniendo datos direccion...', cities: [...state.cities]));
      await Future.delayed(Duration(milliseconds: 100));
      final result = await _addressRepository.getAddressByUserId(userId: event.userId);
      emit(AddressObtained(address: result, cities: [...state.cities]));
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }

  void _saveAddress(SaveAddress event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading(message: 'Guardando datos...', cities: [...state.cities]));
      final userStored = UserStorage();
      final user = userStored.get('user');
      await _addressRepository.saveAddress(addressRequest: event.address.copyWith(userId: user!.id));
      emit(AddressUpdated(cities: [...state.cities]));
    } catch (e) {
      emit(AddressFailure(messageError: e.toString()));
    }
  }
}
