import 'package:injectable/injectable.dart';
import 'package:real_their/core/reusable_components/filter_model.dart';
import 'package:real_their/domain/repo_contract/get_search_property_repo.dart';

@injectable
class GetSearchPropertiesUseCase {
  final GetSearchPropertiesRepo getPropertiesRepo;

  @factoryMethod
  GetSearchPropertiesUseCase(this.getPropertiesRepo);

  Future call(FilterModel? filter,String searchTerm) {
    return getPropertiesRepo.getSearchProperties( filter, searchTerm);
  }
}
