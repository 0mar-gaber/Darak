class FavouriteModel {
  final String userId;
  final String propertyId;
  final String title;
  final String address;
  final double price;
  final String formattedPrice;
  final double area;
  final String mainImageUrl;

  FavouriteModel({
    required this.userId,
    required this.propertyId,
    required this.title,
    required this.address,
    required this.price,
    required this.formattedPrice,
    required this.area,
    required this.mainImageUrl,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      userId: json['userId'],
      propertyId: json['propertyId'],
      title: json['title'],
      address: json['address'],
      price: (json['price'] as num).toDouble(),
      formattedPrice: json['formattedPrice'],
      area: (json['area'] as num).toDouble(),
      mainImageUrl: json['mainImageUrl'],
    );
  }

}
