import 'package:mobile_frontend/src/domain/domain.dart';

class UserForResumeDto {
  final String id;
  final String names;
  final String lastNames;
  final String email;
  final String password;
  final String phone;
  final String description;
  final Role role;
  final ImageProfile imageProfile;
  final UserOcupation userOcupation;
  final bool isPublicProfile;

  UserForResumeDto({
    this.id = '',
    required this.names, 
    required this.lastNames, 
    required this.email, 
    required this.password, 
    required this.phone, 
    this.description = '',
    Role? role,
    ImageProfile? imageProfile,
    UserOcupation? userOcupation,
    this.isPublicProfile = false,
  }) : role = role ?? Role(description: ''),
   imageProfile = imageProfile ?? ImageProfile(),
   userOcupation = userOcupation ?? UserOcupation();

  factory UserForResumeDto.fromMap(Map<String, dynamic> json) => UserForResumeDto(
    id: json["_id"],
    names: json['names'],
    lastNames: json['lastNames'],
    email: json['email'],
    password: json['password'] ?? '',
    phone: json['phone'],
    description: json["description"],
    role: Role.fromMap(json['roleId']),
    imageProfile: ImageProfile.fromMap(json['imageProfile'] ?? ImageProfile().toJson()),
    userOcupation: UserOcupation.fromMap(json['userOcupation'] ?? UserOcupation().toJson()),
    isPublicProfile: json['isPublicProfile'],
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
    'imageProfile': imageProfile.toJson(),
    'userOcupation': userOcupation.toJson(),
    'isPublicProfile': isPublicProfile
  };

  UserForResumeDto copyWith({
    String? id
    ,String? names
    ,String? lastNames
    ,String? email
    ,String? password
    ,String? phone
    ,String? description
    ,Role? role
    ,ImageProfile? imageProfile
    ,UserOcupation? userOcupation
    ,bool? isPublicProfile
  }){
    return UserForResumeDto(
      id: id ?? this.id,
      names: names ?? this.names, 
      lastNames: lastNames ?? this.lastNames, 
      email: email ?? this.email, 
      password: password ?? this.password, 
      phone: phone ?? this.phone, 
      description: description ?? this.description,
      role: role ?? this.role,
      imageProfile: imageProfile ?? this.imageProfile,
      userOcupation: userOcupation ?? this.userOcupation,
      isPublicProfile: isPublicProfile ?? this.isPublicProfile,
    );
  }
}