import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const String _keyDailyDigest = 'notif_daily_digest';
  static const String _keyBreakingNews = 'notif_breaking_new';
  static const String _keySeriesAlerts = 'notif_series_alerts';

  static const bool _defaultDailyDigest = true;
  static const bool _defaultBreakingNews = true;
  static const bool _defaultSeriseAlerts = false;

  Future<bool> getDailyDigest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDailyDigest) ?? _defaultDailyDigest;
  }

  Future<bool> getBreakingNews() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyBreakingNews) ?? _defaultBreakingNews;
  }

  Future<bool> getSeriseAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySeriesAlerts) ?? _defaultSeriseAlerts;
  }

  Future<void> setBreakingNews(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyBreakingNews, value);
  }

  Future<void> setSeriesAlerts(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySeriesAlerts, value);
  }

  Future<void> setDailyDigest(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDailyDigest, value);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyDailyDigest);
    await prefs.remove(_keyBreakingNews);
    await prefs.remove(_keySeriesAlerts);
  }
}
