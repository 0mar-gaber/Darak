class PricePredictionResponseEntity {
  final String predictedPrice2026;

  PricePredictionResponseEntity({required this.predictedPrice2026});

  factory PricePredictionResponseEntity.fromJson(Map<String, dynamic> json) {
    return PricePredictionResponseEntity(
      predictedPrice2026: json["predicted_price_2026"],
    );
  }
}
