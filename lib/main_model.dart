
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
  String tempText = 'zhang jike';

  void changeTempText(){
    tempText = 'ma long';
    notifyListeners();
  }
}