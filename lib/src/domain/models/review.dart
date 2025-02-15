class Review {
  final String id;
  final String reviewerId;
  final String reviewedId;
  final int rating;
  final String comment;

  Review({
    this.id = '', 
    this.reviewerId = '', 
    this.reviewedId = '', 
    this.rating = 0, 
    this.comment = '',
  });

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["_id"],
    reviewerId: json["reviewerId"],
    reviewedId: json["reviewedId"],
    rating: json["rating"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reviewerId": reviewerId,
    "reviewedId": reviewedId,
    "rating": rating,
    "comment": comment,
  };

  Review copyWith({
    String? id, 
    String? reviewerId, 
    String? reviewedId, 
    int? rating, 
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