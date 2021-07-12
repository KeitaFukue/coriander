
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
  String tempText = 'ブックリスト';

  void changeTempText(){
    tempText = 'Book List';
    notifyListeners();
  }
}