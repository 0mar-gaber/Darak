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

import '../../data/data_contract/add_listing_contract.dart' as _i409;
import '../../data/data_contract/auth_contract.dart' as _i128;
import '../../data/data_contract/favourite_contract.dart' as _i906;
import '../../data/data_contract/get_properties_contract.dart' as _i870;
import '../../data/data_contract/get_search_property_contract.dart' as _i333;
import '../../data/data_contract/profile_contract.dart' as _i450;
import '../../data/data_impl/add_listing_impl.dart' as _i831;
import '../../data/data_impl/add_to_favourite_impl.dart' as _i964;
import '../../data/data_impl/auth_impl.dart' as _i645;
import '../../data/data_impl/get_properties_impl.dart' as _i514;
import '../../data/data_impl/get_search_properties_impl.dart' as _i721;
import '../../data/data_impl/profile_impl.dart' as _i331;
import '../../domain/repo_contract/add_listing_repo.dart' as _i790;
import '../../domain/repo_contract/auth_repo.dart' as _i233;
import '../../domain/repo_contract/favourite_repo.dart' as _i704;
import '../../domain/repo_contract/get_properties_repo.dart' as _i1049;
import '../../domain/repo_contract/get_search_property_repo.dart' as _i999;
import '../../domain/repo_contract/profile_repo_contract.dart' as _i765;
import '../../domain/repo_impl/add_listing_repo_impl.dart' as _i1023;
import '../../domain/repo_impl/auth_repo_impl.dart' as _i878;
import '../../domain/repo_impl/favourite_repo_impl.dart' as _i584;
import '../../domain/repo_impl/get_properties_repo_impl.dart' as _i683;
import '../../domain/repo_impl/get_serach_property_repo_impl.dart' as _i1028;
import '../../domain/repo_impl/profile_repo_impl.dart' as _i943;
import '../../domain/use_cases/add_listing_use_case.dart' as _i634;
import '../../domain/use_cases/auth_use_case.dart' as _i1063;
import '../../domain/use_cases/favourite_use_case.dart' as _i784;
import '../../domain/use_cases/get_properties_use_case.dart' as _i82;
import '../../domain/use_cases/get_search_properties_use_case.dart' as _i988;
import '../../domain/use_cases/profile_use_case.dart' as _i454;
import '../../presentation/view_models/add_listing_view_model/add_listing_view_model.dart'
    as _i338;
import '../../presentation/view_models/auth_view_model/auth_view_model.dart'
    as _i964;
import '../../presentation/view_models/favourite_view_model/favourite_view_model.dart' as _i784;
import '../../presentation/view_models/home_tab_view_model/home_tab_view_model.dart'
    as _i545;
import '../../presentation/view_models/profile_view_model/edit_profile_view_model.dart'
    as _i343;
import '../../presentation/view_models/profile_view_model/profile_view_model.dart'
    as _i879;
import '../../presentation/view_models/search_screen_view_model/search_screen_view_model.dart'
    as _i65;
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
    gh.factory<_i409.AddListingContract>(
      () => _i831.AddListingImpl(gh<_i339.ApiManager>()),
    );
    gh.factory<_i784.FavouriteViewModel>(
          () => _i784.FavouriteViewModel(gh<_i784.FavouriteUseCase>()),
    );

    gh.factory<_i906.AddToFavouriteContract>(
      () => _i964.AddToFavouriteImpl(gh<_i339.ApiManager>()),
    );
    gh.factory<_i450.ProfileContract>(
      () => _i331.ProfileImpl(gh<_i339.ApiManager>()),
    );
    gh.factory<_i790.AddListingRepo>(
      () => _i1023.AddListingRepoImpl(gh<_i409.AddListingContract>()),
    );
    gh.factory<_i333.GetSearchPropertiesContract>(
      () => _i721.GetSearchPropertiesImpl(gh<_i339.ApiManager>()),
    );
    gh.factory<_i870.GetPropertiesContract>(
      () => _i514.GetPropertiesImpl(gh<_i339.ApiManager>()),
    );
    gh.factory<_i999.GetSearchPropertiesRepo>(
      () => _i1028.GetSearchPropertiesRepoImpl(
        gh<_i333.GetSearchPropertiesContract>(),
      ),
    );
    gh.factory<_i704.AddToFavouriteRepo>(
      () => _i584.AddToFavouriteRepoImpl(gh<_i906.AddToFavouriteContract>()),
    );
    gh.factory<_i765.ProfileRepoContract>(
      () => _i943.ProfileRepoImpl(gh<_i450.ProfileContract>()),
    );
    gh.factory<_i233.AuthRepo>(
      () => _i878.AuthRepoImpl(gh<_i128.AuthContract>()),
    );
    gh.factory<_i988.GetSearchPropertiesUseCase>(
      () =>
          _i988.GetSearchPropertiesUseCase(gh<_i999.GetSearchPropertiesRepo>()),
    );
    gh.factory<_i634.AddListingUseCase>(
      () => _i634.AddListingUseCase(gh<_i790.AddListingRepo>()),
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
    gh.factory<_i879.ProfileViewModel>(
      () => _i879.ProfileViewModel(gh<_i454.ProfileUseCase>()),
    );
    gh.factory<_i1049.GetPropertiesRepo>(
      () => _i683.GetPropertiesRepoImpl(gh<_i870.GetPropertiesContract>()),
    );
    gh.factory<_i964.AuthViewModel>(
      () => _i964.AuthViewModel(gh<_i1063.AuthUseCase>()),
    );
    gh.factory<_i784.FavouriteUseCase>(
      () => _i784.FavouriteUseCase(gh<_i704.AddToFavouriteRepo>()),
    );
    gh.factory<_i82.GetPropertiesUseCase>(
      () => _i82.GetPropertiesUseCase(gh<_i1049.GetPropertiesRepo>()),
    );
    gh.factory<_i338.AddListingViewModel>(
      () => _i338.AddListingViewModel(gh<_i634.AddListingUseCase>()),
    );
    gh.factory<_i65.GetSearchPropertiesViewModel>(
      () => _i65.GetSearchPropertiesViewModel(
        gh<_i988.GetSearchPropertiesUseCase>(),
      ),
    );
    gh.factory<_i545.GetPropertiesViewModel>(
      () => _i545.GetPropertiesViewModel(gh<_i82.GetPropertiesUseCase>()),
    );
    return this;
  }
}
