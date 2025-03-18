import 'package:mobile_frontend/src/domain/models/city.dart';

class Address {
  final String id;
  final String userId;
  final String jobId;
  final String neighborhood;
  final String directions;
  final City city;

  Address({
    this.id = '', 
    this.userId = '',
    this.jobId = '', 
    this.neighborhood = '', 
    this.directions = '',
    City? city, 
  }) : city = city ?? City(description: '');

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["_id"] ?? '',
    userId: json['userId'] ?? '',
    neighborhood: json['neighborhood'] ?? '',
    directions: json['directions'] ?? '',
    city: City.fromMap(json['cityId'] ?? {}),
    jobId: json['jobId'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    // "_id": id,
    "_id": id,
    "userId": userId,
    "neighborhood": neighborhood,
    "directions": directions,
    'cityId': city.toJson(),
    'jobId': jobId,
  };

  Address copyWith({
    String? id
    ,String? userId
    ,String? jobId
    ,String? neighborhood
    ,String? directions
    ,City? city
  }){
    return Address(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId, 
      neighborhood: neighborhood ?? this.neighborhood, 
      directions: directions ?? this.directions, 
      city: city ?? this.city,
    );
  }
}