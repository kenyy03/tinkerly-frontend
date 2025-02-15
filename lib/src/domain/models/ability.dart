class Ability {
  final String id;
  final String description;
  final String userId;

  Ability({
    this.id = '', 
    this.description = '', 
    this.userId = '',
  });

  factory Ability.fromMap(Map<String, dynamic> json) => Ability(
    id: json["_id"],
    description: json["description"],
    userId: json['userId']
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    'userId': userId
  };

  Ability copyWith({String? id, String? description, String? userId}){
    return Ability(
      id: id ?? this.id, 
      description: description ?? this.description,
      userId: userId ?? this.userId
    );
  }
}