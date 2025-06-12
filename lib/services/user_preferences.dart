import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _startkey = 'custom_day_start';
  static const _endkey = 'custom_day_end';

  Future<void> saveDayTimes(DateTime start, DateTime end) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_startkey, start.toIso8601String());
    await prefs.setString(_endkey, end.toIso8601String());
  }

  Future<(DateTime?, DateTime?)> loadDaytimes() async {
    final prefs = await SharedPreferences.getInstance();
    final startStr = prefs.getString(_startkey);
    final endStr = prefs.getString(_endkey);
    if (startStr == null || endStr == null) return (null, null);
    return (DateTime.parse(startStr), DateTime.parse(endStr));
  }

  Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return !prefs.containsKey(_startkey) || !prefs.containsKey(_endkey);
  }
}
