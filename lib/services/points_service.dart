import 'package:shared_preferences/shared_preferences.dart';

class PointsService {
  static const String _firstScanKey = 'first_scan_completed';
  static const int firstScanPoints = 150;
  static const int regularScanPoints = 50;

  Future<bool> isFirstScan() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_firstScanKey) ?? false);
  }

  Future<void> markFirstScanComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstScanKey, true);
  }
}
