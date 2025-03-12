import 'package:mobile_frontend/src/domain/domain.dart';

class UserPublic {
  final String id;
  final String names;
  final String lastNames;
  final String email;
  final String password;
  final String phone;
  final String description;
  final Role role;
  final ImageProfile imageProfile;
  final Address address;
  final UserOcupation userOcupation;
  final List<UserAbility> userAbilities;
  final List<Review> reviews;
  final bool isPublicProfile;
  final double averageRating;

  UserPublic({
    this.id = '',
    required this.names, 
    required this.lastNames, 
    required this.email, 
    required this.password, 
    required this.phone, 
    this.description = '',
    Role? role,
    ImageProfile? imageProfile,
    Address? address,
    UserOcupation? userOcupation, 
    this.isPublicProfile = false,
    this.userAbilities = const [],
    this.reviews = const [],
    this.averageRating = 0.0
  }) : role = role ?? Role(description: ''),
   imageProfile = imageProfile ?? ImageProfile(),
   address = address ?? Address(),
   userOcupation = userOcupation ?? UserOcupation();

  factory UserPublic.fromMap(Map<String, dynamic> json) => UserPublic(
    id: json["_id"],
    names: json['names'],
    lastNames: json['lastNames'],
    email: json['email'],
    password: json['password'] ?? '',
    phone: json['phone'],
    description: json["description"],
    role: Role.fromMap(json['roleId']),
    imageProfile: ImageProfile.fromMap(json['imageProfile'] ?? ImageProfile().toJson()),
    isPublicProfile: json['isPublicProfile'] ?? false,
    address: Address.fromMap(json['address']),
    userOcupation: UserOcupation.fromMap(json['userOcupation']),
    userAbilities: List.from(json['userAbilities']).map((e) => UserAbility.fromMap(e)).toList(),
    reviews: List.from(json['reviews']).map((e) => Review.fromMap(e)).toList(),
    averageRating: double.tryParse(json['averageRating'].toString()) ?? 0.0
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
    'isPublicProfile': isPublicProfile,
    'address': address.toJson(),
    'userOcupation': userOcupation.toJson(),
    'userAbilities': userAbilities.map((e) => e.toJson()).toList(),
    'reviews': reviews.map((e) => e.toJson()).toList(),
    'averageRating': averageRating,
  };

  UserPublic copyWith({
    String? id
    ,String? names
    ,String? lastNames
    ,String? email
    ,String? password
    ,String? phone
    ,String? description
    ,Role? role
    ,ImageProfile? imageProfile
    ,Address? address
    ,UserOcupation? userOcupation
    ,List<UserAbility>? userAbilities
    ,List<Review>? reviews
    ,bool? isPublicProfile
    ,double? averageRating
  }){
    return UserPublic(
      id: id ?? this.id,
      names: names ?? this.names, 
      lastNames: lastNames ?? this.lastNames, 
      email: email ?? this.email, 
      password: password ?? this.password, 
      phone: phone ?? this.phone, 
      description: description ?? this.description,
      role: role ?? this.role,
      imageProfile: imageProfile ?? this.imageProfile,
      address: address ?? this.address,
      userOcupation: userOcupation ?? this.userOcupation,
      isPublicProfile: isPublicProfile ?? this.isPublicProfile,
      userAbilities: userAbilities ?? this.userAbilities,
      reviews: reviews ?? this.reviews,
      averageRating: averageRating ?? this.averageRating,
    );
  }
}