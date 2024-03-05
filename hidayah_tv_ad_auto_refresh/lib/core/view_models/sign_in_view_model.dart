import 'package:flutter/widgets.dart';
import 'package:hidayah_tv_ad/core/enums/view_state.dart';
import 'package:hidayah_tv_ad/core/services/ad_api.dart';
import 'package:hidayah_tv_ad/core/view_models/base_view_model.dart';
import 'package:hidayah_tv_ad/locator.dart';

class SignInViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final AdAPI _adAPI = locator<AdAPI>();

  String inputID = '100003';
  String inputDomain = 'https://api.labaid.hidayahsmart.solutions/';
  // String inputDomain = 'http://192.168.60.86:5000/';

  Future<bool> signIn() async {
    setViewState(ViewState.busy);

    int? returnedStatusCode = await _adAPI.signInAPI(inputID);

    setViewState(ViewState.idle);

    return returnedStatusCode == 201 ? true : false;
  }

  bool buttonOneSelected = false;

  void changeButtonOneColor(bool value) {
    buttonOneSelected = value;
    notifyListeners();
  }

  String? iDValidator(String value) {
    if (value.isEmpty) {
      return 'Please, enter valid ID';
    }
    return null;
  }
}
