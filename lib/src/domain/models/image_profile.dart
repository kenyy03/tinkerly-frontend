class ImageProfile {
  final String publicId;
  final String url;

  ImageProfile({this.publicId = '', this.url = ''});

  factory ImageProfile.fromMap(Map<String, dynamic> json) => ImageProfile(
    publicId: json['publicId'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() => {
    'publicId': publicId,
    'url': url,
  };

  ImageProfile copyWith({String? publicId, String? url}){
    return ImageProfile(
      publicId: publicId ?? this.publicId,
      url: url ?? this.url
    );
  }
}