import 'package:dartz/dartz.dart';
import 'package:real_their/data/models/analysis_response_model.dart';
import 'package:real_their/data/models/property_price_suggest_model.dart';
import 'package:real_their/domain/entitys/analysis_response_entity.dart';
import 'package:real_their/domain/entitys/property_price_suggest_entity.dart';

abstract class SuggestPriceRepo {

  Future<Either<AnalysisResponseEntity, String>> suggestPrice(PropertyPriceSuggestEntity request);
}