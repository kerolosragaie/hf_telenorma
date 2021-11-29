import 'package:hf/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LicenseData {
  static Future<bool> isLicenseFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic _license = prefs.get("license") ?? '';
    if (license == _license) {
      return true;
    }
    return false;
  }

  static Future<String> saveLicenseData(String _license) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("license", _license);
    return _license;
  }

  static Future<String> getLicenseData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic license = prefs.get("license") ?? '';
    return license;
  }

  static Future deleteLicenseData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("license");
  }
}
