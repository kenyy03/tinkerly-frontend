
import '../../../../domain/models/user.dart';
import 'dart:convert';
import 'package:mobile_frontend/src/config/storage/shared_prefs.dart';
import 'package:mobile_frontend/src/domain/abstractions/istorage_service.dart';

class UsersStorage implements IStorageService<List<User>> {
  @override
  Future<void> save(String key, List<User> users) async {
    final prefs = SharedPrefs.instance;
    String encodedData = jsonEncode(users.map((e) => e.toJson()).toList());
    await prefs.setString(key, encodedData);
  }

  @override
  List<User>? get(String key)  {
    final prefs = SharedPrefs.instance;
    String? data = prefs.getString(key);
    if (data != null) {
      final users = List.from(jsonDecode(data));
      return users.map((e) => User.fromMap(e)).toList();
    }
    return null;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = SharedPrefs.instance;
    await prefs.remove(key);
  }
}
