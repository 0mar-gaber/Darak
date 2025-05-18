import 'package:dartz/dartz.dart';
import 'package:real_their/core/reusable_components/filter_model.dart';

import '../models/search_property_response.dart';

abstract class GetSearchPropertiesContract {
  Future<Either<List<SearchPropertyResponse>, String>> getSearchProperties(FilterModel? filter, String searchTerm);
}
