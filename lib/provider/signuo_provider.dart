import 'package:flutter/foundation.dart';

class SignupProvider with ChangeNotifier{
  bool _loading = false;
  bool get loading => _loading;

  void Loading(bool value){
    _loading = value;
    notifyListeners();
  }


}