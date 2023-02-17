import 'package:flutter/foundation.dart';

class loadingProvider with ChangeNotifier{
  bool _loading = false;
  bool get loading => _loading;

  void loaded(bool value){
    _loading = value;
    notifyListeners();
  }


}