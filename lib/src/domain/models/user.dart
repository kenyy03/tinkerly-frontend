import 'package:mobile_frontend/src/domain/domain.dart';

class User {
  final String id;
  final String names;
  final String lastNames;
  final String email;
  final String password;
  final String phone;
  final String description;
  final Role role;

  User({
    this.id = '',
    required this.names, 
    required this.lastNames, 
    required this.email, 
    required this.password, 
    required this.phone, 
    this.description = '',
    Role? role
  }) : role = role ?? Role(description: '') ;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["_id"],
    names: json['names'],
    lastNames: json['lastNames'],
    email: json['email'],
    password: json['password'] ?? '',
    phone: json['phone'],
    description: json["description"],
    role: Role.fromMap(json['roleId'])
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "names": names,
    "lastNames": lastNames,
    "email": email,
    "password": password,
    "phone": phone,
    "description": description,
    'roleId': role.toJson(),
  };

  User copyWith({
    String? id
    ,String? names
    ,String? lastNames
    ,String? email
    ,String? password
    ,String? phone
    ,String? description
    ,Role? role
  }){
    return User(
      id: id ?? this.id,
      names: names ?? this.names, 
      lastNames: lastNames ?? this.lastNames, 
      email: email ?? this.email, 
      password: password ?? this.password, 
      phone: phone ?? this.phone, 
      description: description ?? this.description,
      role: role ?? this.role
    );
  }
  
}