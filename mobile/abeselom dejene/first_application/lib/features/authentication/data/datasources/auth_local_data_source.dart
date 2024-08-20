import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> clearToken();
  Future<void> cacheLoginStatus(bool isLoggedIn);
  Future<bool> getLoginStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const CACHED_TOKEN = 'CACHED_TOKEN';
  static const LOGGED_IN_STATUS = 'LOGGED_IN_STATUS';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(CACHED_TOKEN, token);
  }

  @override
  Future<String?> getCachedToken() async {
    return sharedPreferences.getString(CACHED_TOKEN);
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(CACHED_TOKEN);
    await cacheLoginStatus(false);
  }

  @override
  Future<void> cacheLoginStatus(bool isLoggedIn) async {
    await sharedPreferences.setBool(LOGGED_IN_STATUS, isLoggedIn);
  }

  @override
  Future<bool> getLoginStatus() async {
    return sharedPreferences.getBool(LOGGED_IN_STATUS) ?? false;
  }
}
