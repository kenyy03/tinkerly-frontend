
import '../../../../domain/models/user.dart';
import 'dart:convert';
import 'package:mobile_frontend/src/config/storage/shared_prefs.dart';
import 'package:mobile_frontend/src/domain/abstractions/istorage_service.dart';

class UserStorage implements IStorageService<User> {
  @override
  Future<void> save(String key, User user) async {
    final prefs = SharedPrefs.instance;
    String encodedData = jsonEncode(user.toJson());
    await prefs.setString(key, encodedData);
  }

  @override
  User? get(String key)  {
    final prefs = SharedPrefs.instance;
    String? data = prefs.getString(key);
    if (data != null) {
      return User.fromMap(jsonDecode(data));
    }
    return null;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = SharedPrefs.instance;
    await prefs.remove(key);
  }
}
