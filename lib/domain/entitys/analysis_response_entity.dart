class AnalysisResponseEntity {
  final String analysisResult; // نتيجة التحليل (مثل "Normal")
  final String suggestedPrice; // السعر المقترح (نص كما في الـ JSON، يمكنك تحويله إلى double لاحقاً إذا احتجت لحسابات)

  // constructor
  AnalysisResponseEntity({
    required this.analysisResult,
    required this.suggestedPrice,
  });

  // factory constructor لتحويل JSON إلى كائن AnalysisResult
  factory AnalysisResponseEntity.fromJson(Map<String, dynamic> json) {
    return AnalysisResponseEntity(
      analysisResult: json['analysis_result'] as String,
      suggestedPrice: json['suggested_price'] as String,
    );
  }

  // ميثود لتحويل كائن AnalysisResult إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'analysis_result': analysisResult,
      'suggested_price': suggestedPrice,
    };
  }
}