
import 'package:flutter/material.dart';


class DialogPageModel with ChangeNotifier{
  bool _showCalendar;

  bool _disabled;

  bool get showCalendar => _showCalendar;


  bool get disabled => _disabled;

  void setShowCalendar(bool show){
    this._showCalendar=show;
    notifyListeners();
  }
}