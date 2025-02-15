class City {
  final String id;
  final String description;

  City({
    this.id = '', 
    required this.description
  });

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["_id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
  };

  City copyWith({String? id, String? description}){
    return City(
      id: id ?? this.id, 
      description: description ?? this.description,
    );
  }
}