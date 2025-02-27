import 'package:mobile_frontend/src/domain/domain.dart';

class UserAbility {
  final String id;
  final String userId;
  // final double hourlyRate;
  // final double serviceFee;
  final Ability ability;

  UserAbility({
    this.id = '', 
    this.userId = '', 
    // this.hourlyRate = 0.0,
    // this.serviceFee = 0.0,
    Ability? ability
  }) : ability = ability ?? Ability();

  factory UserAbility.fromMap(Map<String, dynamic> json) => UserAbility(
    id: json["_id"] ?? '',
    userId: json['userId'] ?? '',
    // hourlyRate: json['hourlyRate'] ?? 0.0,
    // serviceFee: json['serviceFee'] ?? 0.0,
    ability: Ability.fromMap(json['abilityId'] ?? {})
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    // 'hourlyRate': hourlyRate,
    // 'serviceFee': serviceFee,
    'abilityId': ability.toJson(),
  };

  UserAbility copyWith({
    String? id
    ,String? userId
    // ,double? hourlyRate
    // ,double? serviceFee
    ,Ability? ability
  }){
    return UserAbility(
      id: id ?? this.id,
      userId: userId ?? this.userId, 
      // hourlyRate: hourlyRate ?? this.hourlyRate,
      // serviceFee: serviceFee ?? this.hourlyRate,
      ability: ability ?? this.ability,
    );
  }
}