import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/data/data_contract/suggest_price_contract.dart';
import 'package:real_their/data/models/property_price_suggest_model.dart';
import 'package:real_their/domain/entitys/analysis_response_entity.dart';
import 'package:real_their/domain/entitys/property_price_suggest_entity.dart';

import '../repo_contract/suggest_price_repo.dart';


@Injectable(as: SuggestPriceRepo)
class SuggestPriceRepoImpl extends SuggestPriceRepo {
  final SuggestPriceContract contract;

  @factoryMethod
  SuggestPriceRepoImpl(this.contract);

  @override
  Future<Either<AnalysisResponseEntity, String>> suggestPrice(PropertyPriceSuggestEntity request) async {
    PropertyPriceSuggestModel priceSuggestEntity = PropertyPriceSuggestModel(
        areaSqm: request.areaSqm,
        propertyType: request.propertyType,
        bedrooms: request.bedrooms,
        bathrooms: request.bathrooms,
        buildingAgeYears: request.buildingAgeYears,
        floorLevel: request.floorLevel,
        location: request.location,
        price: request.price
    );
    final result = await contract.suggestPrice(priceSuggestEntity);
    return result.fold(
          (response) {
        AnalysisResponseEntity analysisResponseEntity = AnalysisResponseEntity(analysisResult: response.analysisResult,suggestedPrice: response.suggestedPrice);
        return Left(analysisResponseEntity);
      },
          (error) => Right(error),
    );
  }

}
