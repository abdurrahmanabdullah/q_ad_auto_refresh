import 'package:flutter/foundation.dart';
import 'package:hidayah_tv_ad/core/enums/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
