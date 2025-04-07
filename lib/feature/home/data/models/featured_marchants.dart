class FeaturedMarchantsModel {
  final String name, imageUrl;
  final bool isOnline;

  FeaturedMarchantsModel({
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });

  factory FeaturedMarchantsModel.fromJson(Map<String, dynamic> json) =>
      FeaturedMarchantsModel(
        name: json['name'],
        imageUrl: json['image_url'],
        isOnline: json['is_online'],
      );
}
