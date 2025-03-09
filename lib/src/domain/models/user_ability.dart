import 'package:mobile_frontend/src/domain/domain.dart';

class UserAbility {
  final String id;
  final String userId;
  final Ability ability;

  UserAbility({
    this.id = '', 
    this.userId = '', 
    Ability? ability
  }) : ability = ability ?? Ability();

  factory UserAbility.fromMap(Map<String, dynamic> json) => UserAbility(
    id: json["_id"] ?? '',
    userId: json['userId'] ?? '',
    ability: Ability.fromMap(json['abilityId'] ?? {})
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    'abilityId': ability.toJson(),
  };

  UserAbility copyWith({
    String? id
    ,String? userId
    ,Ability? ability
  }){
    return UserAbility(
      id: id ?? this.id,
      userId: userId ?? this.userId, 
      ability: ability ?? this.ability,
    );
  }
}