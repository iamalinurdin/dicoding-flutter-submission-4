import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static const dailyNews = 'DAILY_NEWS';

  final Future<SharedPreferences> sharedPreferences;

  PreferenceHelper({required this.sharedPreferences});

  Future<bool> get getDailyNews async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyNews) ?? false;
  }

  void setDailyNews(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyNews, value);
  }
}