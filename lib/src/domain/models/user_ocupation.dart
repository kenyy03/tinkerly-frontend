class UserOcupation {
  final String id;
  final String userId;
  final String ocupationId;
  final double hourlyRate;
  final double serviceFee;

  UserOcupation({
    this.id = '',
    this.userId = '', 
    this.ocupationId = '', 
    this.hourlyRate = 0.0, 
    this.serviceFee = 0.0
  });

    factory UserOcupation.fromMap(Map<String, dynamic> json) => UserOcupation(
    id: json["_id"],
    userId: json["userId"],
    ocupationId: json["ocupationId"],
    hourlyRate: json["hourlyRate"],
    serviceFee: json["serviceFee"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "ocupationId": ocupationId,
    "hourlyRate": hourlyRate,
    "serviceFee": serviceFee,
  };

  UserOcupation copyWith({
    String? id, 
    String? userId, 
    String? ocupationId, 
    double? hourlyRate, 
    double? serviceFee
  }){
    return UserOcupation(
      id: id ?? this.id, 
      userId: userId ?? this.userId,
      ocupationId: ocupationId ?? this.ocupationId,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      serviceFee: serviceFee ?? this.serviceFee,
    );
  }

}