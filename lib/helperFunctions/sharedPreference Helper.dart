import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdkey = "USERIDKEY";
  static String userNamekey = "USERNAMEKEY";
  static String displayNameKey = "USERIDNAMEKEY";
  static String userEmailkey = "USERIDEMAILKEY";
  static String userProfilePickey = "USERIDPROFILEPICKEY";

  Future<bool> saveUserEmail(String? getUseremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailkey, getUseremail!);
  }

  Future<bool> saveUserId(String getUserid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdkey, getUserid);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNamekey, getUserName);
  }

  Future<bool> saveDisplayName(String? getDiasplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getDiasplayName!);
  }

  Future<bool> saveUserProfileUrl(String? getUserProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePickey, getUserProfile!);
  }

  getUserName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString(userNamekey) == null) {
      return null;
    } else {
      return _prefs.getString(userNamekey);
    }
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailkey);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdkey);
  }

  Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String?> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePickey);
  }
}
