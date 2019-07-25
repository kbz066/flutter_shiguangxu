
import 'package:flutter/material.dart';


class DialogPageModel with ChangeNotifier{
  bool _showCalendar;

  bool get showCalendar => _showCalendar;


  void setShowCalendar(bool show){
    this._showCalendar=show;
    notifyListeners();
  }
}