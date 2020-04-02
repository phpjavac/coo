import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  bool _loginState;
  bool _showOverlay;
  User(this._loginState, this._showOverlay);

  get loginState => _loginState;
  get showOverlay => _showOverlay;

  void changeLoginState(bool param0) {
    _loginState = param0;
  }

  void changeShowOverlay(value) {
    _showOverlay = value;
    // notifyListeners();
  }
}
