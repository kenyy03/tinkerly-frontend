part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

final class LoadCities extends AddressEvent {}

final class NeighborhoodOnChanged extends AddressEvent {
  final String neighborhood;

  const NeighborhoodOnChanged({required this.neighborhood});
}

final class DirectionsOnChanged extends AddressEvent {
  final String directions;

  const DirectionsOnChanged({required this.directions});
}

final class CityOnChanged extends AddressEvent {
  final City city;

  const CityOnChanged({required this.city});
}
