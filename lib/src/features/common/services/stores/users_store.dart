
import 'package:mobile_frontend/src/domain/domain.dart';
import 'dart:convert';
import 'package:mobile_frontend/src/config/storage/shared_prefs.dart';

class UsersStorage implements IStorageService<List<UserPublic>> {
  @override
  Future<void> save(String key, List<UserPublic> users) async {
    final prefs = SharedPrefs.instance;
    String encodedData = jsonEncode(users.map((e) => e.toJson()).toList());
    await prefs.setString(key, encodedData);
  }

  @override
  List<UserPublic>? get(String key)  {
    final prefs = SharedPrefs.instance;
    String? data = prefs.getString(key);
    if (data != null) {
      final users = List.from(jsonDecode(data));
      return users.map((e) => UserPublic.fromMap(e)).toList();
    }
    return null;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = SharedPrefs.instance;
    await prefs.remove(key);
  }
}
