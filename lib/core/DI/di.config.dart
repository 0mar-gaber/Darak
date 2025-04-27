// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_contract/auth_contract.dart' as _i128;
import '../../data/data_contract/profile_contract.dart' as _i450;
import '../../data/data_impl/auth_impl.dart' as _i645;
import '../../data/data_impl/profile_impl.dart' as _i331;
import '../../domain/repo_contract/auth_repo.dart' as _i233;
import '../../domain/repo_contract/profile_repo_contract.dart' as _i765;
import '../../domain/repo_impl/auth_repo_impl.dart' as _i878;
import '../../domain/repo_impl/profile_repo_impl.dart' as _i943;
import '../../domain/use_cases/auth_use_case.dart' as _i1063;
import '../../domain/use_cases/profile_use_case.dart' as _i454;
import '../../presentation/view_models/auth_view_model/auth_view_model.dart'
    as _i964;
import '../../presentation/view_models/profile_view_model/edit_profile_view_model.dart'
    as _i343;
import '../../presentation/view_models/profile_view_model/profile_view_model.dart';
import '../api/api_manger.dart' as _i339;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i339.ApiManager>(() => _i339.ApiManager());
    gh.factory<_i128.AuthContract>(
      () => _i645.AuthImpl(gh<_i339.ApiManager>()),
    );
    gh.factory<_i450.ProfileContract>(
      () => _i331.ProfileImpl(gh<_i339.ApiManager>()),
    );
    gh.factory<_i765.ProfileRepoContract>(
      () => _i943.ProfileRepoImpl(gh<_i450.ProfileContract>()),
    );
    gh.factory<_i233.AuthRepo>(
      () => _i878.AuthRepoImpl(gh<_i128.AuthContract>()),
    );
    gh.factory<_i1063.AuthUseCase>(
      () => _i1063.AuthUseCase(gh<_i233.AuthRepo>()),
    );
    gh.factory<_i454.ProfileUseCase>(
      () => _i454.ProfileUseCase(gh<_i765.ProfileRepoContract>()),
    );
    gh.factory<_i343.EditProfileViewModel>(
      () => _i343.EditProfileViewModel(gh<_i454.ProfileUseCase>()),
    );
    gh.factory<ProfileViewModel>(
      () => ProfileViewModel(gh<_i454.ProfileUseCase>()),
    );
    gh.factory<_i964.AuthViewModel>(
      () => _i964.AuthViewModel(gh<_i1063.AuthUseCase>()),
    );
    return this;
  }
}
