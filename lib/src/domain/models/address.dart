import 'package:mobile_frontend/src/domain/models/city.dart';

class Address {
  final String id;
  final String userId;
  final String neighborhood;
  final String directions;
  final City city;

  Address({
    this.id = '', 
    this.userId = '', 
    this.neighborhood = '', 
    this.directions = '',
    City? city, 
  }) : city = city ?? City(description: '');

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["_id"],
    userId: json['userId'],
    neighborhood: json['neighborhood'],
    directions: json['directions'],
    city: City.fromMap(json['cityId'])
  );

  Map<String, dynamic> toJson() => {
    // "_id": id,
    "_id": id,
    "userId": userId,
    "neighborhood": neighborhood,
    "directions": directions,
    'cityId': city.id,
  };

  Address copyWith({
    String? id
    ,String? userId
    ,String? neighborhood
    ,String? directions
    ,City? city
  }){
    return Address(
      id: id ?? this.id,
      userId: userId ?? this.userId, 
      neighborhood: neighborhood ?? this.neighborhood, 
      directions: directions ?? this.directions, 
      city: city ?? this.city,
    );
  }
}