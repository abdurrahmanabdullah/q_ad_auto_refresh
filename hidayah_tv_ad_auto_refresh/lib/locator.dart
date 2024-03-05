import 'package:get_it/get_it.dart';
import 'package:hidayah_tv_ad/core/services/ad_api.dart';
import 'package:hidayah_tv_ad/core/view_models/base_view_model.dart';
import 'package:hidayah_tv_ad/core/view_models/home_view_model.dart';
import 'package:hidayah_tv_ad/core/view_models/sign_in_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BaseViewModel());

  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => SignInViewModel());

  locator.registerLazySingleton(() => AdAPI());
}
