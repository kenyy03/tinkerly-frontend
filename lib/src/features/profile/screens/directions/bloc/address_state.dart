part of 'address_bloc.dart';

sealed class AddressState extends Equatable {
  AddressState({ this.cities = const [], Address? address}) : address = address ?? Address();
  final List<City> cities;
  final Address address;
  
  @override
  List<Object> get props => [cities, address];
}

final class AddressInitial extends AddressState {}
final class AddressLoading extends AddressState {
  final String message;

  AddressLoading({this.message = 'Obteniendo ciudades...'});
}

final class AddressFailure extends AddressState {
  final String messageError;

  AddressFailure({this.messageError = 'Internal Server Error...'});
}

final class CitiesObtained extends AddressState {
  CitiesObtained({super.cities});
}

final class AddressFilled extends AddressState {
  AddressFilled({super.address, super.cities});
}