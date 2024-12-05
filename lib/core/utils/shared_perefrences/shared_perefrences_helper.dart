import 'package:shared_preferences/shared_preferences.dart';



const KEY_ACCESS_TOKEN = "PREF_KEY_ACCESS_TOKEN";
const String PREFS_KEY_LANG = 'PREFS_KEY_LANG';
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = 'PREFS_KEY_ONBOARDING_SCREEN_VIEWED';
const String PREFS_KEY_IS_USER_LOGGED_IN = 'PREFS_KEY_IS_USER_LOGGED_IN';

// Filtering
const String PREFS_KEY_FILTER_AMOUNT = 'PREFS_KEY_FILTER_AMOUNT';

// User info
const String PREFS_KEY_NAME = 'PREFS_KEY_NAME';
const String PREFS_KEY_PHONE = 'PREFS_KEY_PHONE';
const String PREFS_KEY_USER_ID = 'PREFS_KEY_USER_ID';

const String PREFS_KEY_LONGITUDE = 'PREFS_KEY_LONGITUDE';
const String PREFS_KEY_LATITUDE = 'PREFS_KEY_LATITUDE';



class AppPreferences{
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  // LONGITUDE
  Future<void> setLongitude(String? longitude) async{
    _sharedPreferences.setString(PREFS_KEY_LONGITUDE, longitude ?? '');
  }

  String getLongitude() {
    return _sharedPreferences.getString(PREFS_KEY_LONGITUDE) ?? '';
  }

  // LATITUDE
  Future<void> setLatitude(String? latitude) async{
    _sharedPreferences.setString(PREFS_KEY_LATITUDE, latitude ?? '');
  }

  String getLatitude() {
    return _sharedPreferences.getString(PREFS_KEY_LATITUDE) ?? '';
  }

  // NAME
  Future<void> setName(String? name) async{
    _sharedPreferences.setString(PREFS_KEY_NAME, name ?? '');
  }

  String getName() {
    return _sharedPreferences.getString(PREFS_KEY_NAME) ?? '';
  }

  // Phone
  Future<void> setPhone(String? phone) async{
    _sharedPreferences.setString(PREFS_KEY_PHONE, phone ?? '');
  }

  String getPhone() {
    return _sharedPreferences.getString(PREFS_KEY_PHONE) ?? '';
  }

  // Phone
  Future<void> setId(String? id) async{
    _sharedPreferences.setString(PREFS_KEY_USER_ID, id ?? '');
  }

  String getId() {
    return _sharedPreferences.getString(PREFS_KEY_USER_ID) ?? '';
  }


  // Lang
  Future<void> setLanguage(String? language) async{
    _sharedPreferences.setString(PREFS_KEY_LANG, language ?? 'en');
  }

  String getLanguage() {
    return _sharedPreferences.getString(PREFS_KEY_LANG) ?? 'en';
  }

  // OnBoarding
  Future<void> setOnBoardingScreenViewed() async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  bool isOnBoardingScreenViewed() {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ?? false;
  }

  // Login
  Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  // Login
  Future<void> setAccessToken(String token) async{
    _sharedPreferences.setString(KEY_ACCESS_TOKEN, token);
  }

  String getAccessToken() {
    return _sharedPreferences.getString(KEY_ACCESS_TOKEN) ?? '';
  }

  bool hasAccessToken() {
    return _sharedPreferences.containsKey(KEY_ACCESS_TOKEN);
  }

  Future<bool> removeAccessToken() async{
    return _sharedPreferences.remove(KEY_ACCESS_TOKEN);
  }

  Future<void> clearForLogOut() {
    return _sharedPreferences!.remove(KEY_ACCESS_TOKEN);
  }
}