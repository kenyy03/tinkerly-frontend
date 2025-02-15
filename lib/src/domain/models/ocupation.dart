class Ocupation {
  final String id;
  final String description;

  Ocupation({
    this.id = '', 
    required this.description
  });

  factory Ocupation.fromMap(Map<String, dynamic> json) => Ocupation(
    id: json["_id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
  };

  Ocupation copyWith({String? id, String? description}){
    return Ocupation(
      id: id ?? this.id, 
      description: description ?? this.description,
    );
  }
}