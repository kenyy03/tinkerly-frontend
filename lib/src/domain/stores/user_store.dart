import 'dart:convert';
import 'package:mobile_frontend/src/config/storage/shared_prefs.dart';
import 'package:mobile_frontend/src/domain/abstractions/storage_service.dart';

import '../models/user.dart';

class UserStorage implements StorageService<User> {
  @override
  Future<void> save(String key, User user) async {
    final prefs = SharedPrefs.instance;
    String encodedData = jsonEncode(user.toJson());
    await prefs.setString(key, encodedData);
  }

  @override
  Future<User?> get(String key) async {
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
