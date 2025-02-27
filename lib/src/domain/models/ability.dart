class Ability {
  final String id;
  final String description;
  final bool isSelected;
  // final String userId;

  Ability({
    this.id = '', 
    this.description = '', 
    // this.userId = '',
    this.isSelected = false,
  });

  factory Ability.fromMap(Map<String, dynamic> json) => Ability(
    id: json["_id"],
    description: json["description"],
    // userId: json['userId']
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    // 'userId': userId
  };

  Ability copyWith({String? id, String? description, bool? isSelected }){
    return Ability(
      id: id ?? this.id, 
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
      // userId: userId ?? this.userId
    );
  }
}