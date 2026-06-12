// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class TokenStorage {
//   static const _storage = FlutterSecureStorage();
//   static const _tokenKey = 'auth_token';

//   static Future<void> saveToken(String token) async {
//     await _storage.write(key: _tokenKey, value: token);
//   }

//   static Future<String?> getToken() async {
//     return await _storage.read(key: _tokenKey);
//   }

//   static Future<void> deleteToken() async {
//     await _storage.delete(key: _tokenKey);
//   }

//   static Future<bool> hasToken() async {
//     final token = await _storage.read(key: _tokenKey);
//     return token != null && token.isNotEmpty;
//   }
// }
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _donorKey = 'donor_data';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<bool> hasToken() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Saves the full donor object as JSON so we can restore the
  /// complete session on next launch — not just the token.
  static Future<void> saveDonor(Map<String, dynamic> donorJson) async {
    await _storage.write(key: _donorKey, value: jsonEncode(donorJson));
  }

  /// Returns the saved donor JSON, or null if nothing is stored.
  static Future<Map<String, dynamic>?> getDonor() async {
    final raw = await _storage.read(key: _donorKey);
    if (raw == null || raw.isEmpty) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  /// Clears both the token and donor data (call on logout).
  static Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _donorKey);
  }
}
