import 'package:dartz/dartz.dart';
import 'package:real_their/data/models/analysis_response_model.dart';
import 'package:real_their/data/models/property_price_suggest_model.dart';

abstract class SuggestPriceContract {

  Future<Either<AnalysisResponse, String>> suggestPrice(PropertyPriceSuggestModel request);
}