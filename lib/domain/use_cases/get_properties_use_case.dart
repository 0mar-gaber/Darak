import 'package:injectable/injectable.dart';
import 'package:real_their/domain/repo_contract/get_properties_repo.dart';

@injectable
class GetPropertiesUseCase {
  final GetPropertiesRepo getPropertiesRepo;

  @factoryMethod
  GetPropertiesUseCase(this.getPropertiesRepo);

  callGetProperties() {
    return getPropertiesRepo.getProperties();
  }
  callGetNearMeProperties() {
    return getPropertiesRepo.getNearMeProperties();
  }
}
