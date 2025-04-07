class ProductsModel {
  final String name,
      originalPrice,
      discountedPrice,
      mainImage,
      tagImage,
      description;

  ProductsModel({
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.mainImage,
    required this.tagImage,
    required this.description,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    name: json['product_name'],
    originalPrice: json['original_price'],
    discountedPrice: json['discounted_price'],
    mainImage: json['main_image'],
    tagImage: json['tag_image'],
    description: json['description'],
  );
}
