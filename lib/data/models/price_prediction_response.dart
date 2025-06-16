class PricePredictionResponse {
  final String predictedPrice2026;

  PricePredictionResponse({required this.predictedPrice2026});

  factory PricePredictionResponse.fromJson(Map<String, dynamic> json) {
    return PricePredictionResponse(
      predictedPrice2026: json["predicted_price_2026"],
    );
  }
}
