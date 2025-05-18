import 'package:dartz/dartz.dart';
import 'package:real_their/core/reusable_components/filter_model.dart';
import 'package:real_their/domain/entitys/search_property_response_entity.dart';


abstract class GetSearchPropertiesRepo {
  Future<Either<List<SearchPropertyResponseEntity>, String>> getSearchProperties(FilterModel? filter, String searchTerm);

}
