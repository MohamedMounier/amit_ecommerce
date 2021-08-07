
import 'package:flutter/material.dart';

class ModelHud extends ChangeNotifier{
  bool isLoading=false;
  ChangeisLoading(bool value){
    isLoading=value;
    notifyListeners();

  }

}