import '../domain.dart';

class Review {
  final String id;
  final User reviewerId;
  final String reviewedId;
  final double rating;
  final String comment;

  Review({
    this.id = '', 
    User? reviewerId, 
    this.reviewedId = '', 
    this.rating = 0.0, 
    this.comment = '',
  }) : reviewerId = reviewerId ?? User(
    names: '', 
    lastNames: '', 
    email: '', 
    password: '', 
    phone: ''
  );

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["_id"],
    reviewerId: User.fromMap(json["reviewerId"]),
    reviewedId: json["reviewedId"],
    rating: double.tryParse(json["rating"].toString()) ?? 0.0,
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reviewerId": reviewerId.toJson(),
    "reviewedId": reviewedId,
    "rating": rating,
    "comment": comment,
  };

  Review copyWith({
    String? id, 
    User? reviewerId, 
    String? reviewedId, 
    double? rating, 
    String? comment
  }){
    return Review(
      id: id ?? this.id, 
      reviewerId: reviewerId ?? this.reviewerId,
      reviewedId: reviewedId ?? this.reviewedId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }
}