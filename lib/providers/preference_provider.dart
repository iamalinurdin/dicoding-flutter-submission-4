import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_app/data/preferences/preference_helper.dart';

class PreferenceProvider with ChangeNotifier {
  bool _isEnabledNotification = false;
  PreferenceHelper preferenceHelper;

  PreferenceProvider({required this.preferenceHelper}) {
    _getIsEnabledNotification();
  }

  bool get isEnabledNotification => _isEnabledNotification;

  void _getIsEnabledNotification() async {
    _isEnabledNotification = await preferenceHelper.getDailyNews;
    notifyListeners();
  }

  void enabledNotification(bool value) async {
    preferenceHelper.setDailyNews(value);
    _getIsEnabledNotification();
  }
}