class FavouriteEntity {
  final String userId;
  final String propertyId;
  final String title;
  final String address;
  final double price;
  final String formattedPrice;
  final double area;
  final String mainImageUrl;

  FavouriteEntity({
    required this.userId,
    required this.propertyId,
    required this.title,
    required this.address,
    required this.price,
    required this.formattedPrice,
    required this.area,
    required this.mainImageUrl,
  });
}
