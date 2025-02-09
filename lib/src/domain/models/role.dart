class Role {
  final String id;
  final String description;
  final bool isSelected;

  Role({required this.id, required this.description, this.isSelected = false});

  factory Role.fromMap(Map<String, dynamic> json) => Role(
    id: json["_id"],
    description: json["description"],
  );

  Role copyWith({String? id, String? description, bool? isSelected}){
    return Role(
      id: id ?? this.id, 
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected
    );
  }

}