import 'package:mobile_frontend/src/domain/domain.dart';

class UserOcupation {
  final String id;
  final String userId;
  final Ocupation ocupation;
  final double hourlyRate;
  final double serviceFee;

  UserOcupation({
    this.id = '',
    this.userId = '', 
    Ocupation? ocupation, 
    this.hourlyRate = 0.0, 
    this.serviceFee = 0.0
  }) : ocupation = ocupation ?? Ocupation(description: '');

    factory UserOcupation.fromMap(Map<String, dynamic> json) => UserOcupation(
    id: json["_id"],
    userId: json["userId"],
    ocupation: Ocupation.fromMap(json["ocupationId"] ?? {}),
    hourlyRate: double.tryParse(json["hourlyRate"].toString()) ?? 0.0 ,
    serviceFee: double.tryParse(json["serviceFee"].toString()) ?? 0.0 ,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "ocupationId": ocupation.toJson(),
    "hourlyRate": hourlyRate,
    "serviceFee": serviceFee,
  };

  UserOcupation copyWith({
    String? id, 
    String? userId, 
    Ocupation? ocupation, 
    double? hourlyRate, 
    double? serviceFee
  }){
    return UserOcupation(
      id: id ?? this.id, 
      userId: userId ?? this.userId,
      ocupation: ocupation ?? this.ocupation,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      serviceFee: serviceFee ?? this.serviceFee,
    );
  }
}