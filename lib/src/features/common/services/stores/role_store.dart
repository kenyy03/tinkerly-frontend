import 'dart:convert';
import 'package:mobile_frontend/src/config/storage/shared_prefs.dart';
import 'package:mobile_frontend/src/domain/abstractions/istorage_service.dart';

import '../../../../domain/models/role.dart';

class RoleStore implements IStorageService<List<Role>> {
  // static const String _key = 'roles';

  @override
  Future<void> save(String key, List<Role> roles) async {
    final prefs = SharedPrefs.instance;
    String encodedData = jsonEncode(roles.map((role) => role.toJson()).toList());
    await prefs.setString(key, encodedData);
  }

  @override
  List<Role>? get(String key) {
    final prefs = SharedPrefs.instance;
    String? data = prefs.getString(key);
    if (data != null) {
      List<dynamic> decodedData = jsonDecode(data);
      return decodedData.map((role) => Role.fromMap(role)).toList();
    }
    return null;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = SharedPrefs.instance;
    await prefs.remove(key);
  }
}
