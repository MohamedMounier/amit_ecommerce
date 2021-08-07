import 'package:flutter/material.dart';

class AmountProvider extends ChangeNotifier{

  void minusAmount(amount) {
    if(amount==1){
      amount=1;
    }else{
      amount--;
    }
    notifyListeners();
  }

  void addAmount(amount) {
    if(amount<50){
     amount++;
    }else{
   amount=50;
    }
    notifyListeners();
  }


}