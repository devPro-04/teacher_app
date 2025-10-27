import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveJwtToken(String token) async {
    try {
      await _secureStorage.write(key: 'jwt_token', value: token);
    } catch (e) {
      // Handle the error here, e.g., print or log the error
    }
  }

  Future<String?> getJwtToken() async {
    try {
      return await _secureStorage.read(key: 'jwt_token');
    } catch (e) {
      return null;
    }
  }

  Future<bool?> deleteJwtToken() async {
    try {
      await _secureStorage.delete(key: 'jwt_token');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveCredentials(String email, String password) async {
    try {
      await _secureStorage.write(key: 'email', value: email);
      await _secureStorage.write(key: 'password', value: password);
    } catch (e) {
      return;
    }
  }

  Future<Map<String, String?>> getCredentials() async {
    try {
      final email = await _secureStorage.read(key: 'email');
      final password = await _secureStorage.read(key: 'password');
      return {'email': email, 'password': password};
    } catch (e) {
      return {'email': null, 'password': null};
    }
  }

  Future<void> saveFullname(String fullname) async {
    try {
      await _secureStorage.write(key: 'fullname', value: fullname);
    } catch (e) {
      // Handle the error here, e.g., print or log the error
    }
  }

  Future<String?> getFullname() async {
    try {
      return await _secureStorage.read(key: 'fullname');
    } catch (e) {
      return null;
    }
  }

  Future<bool?> deleteFullname() async {
    try {
      await _secureStorage.delete(key: 'fullname');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> savePhoto(String photo) async {
    try {
      await _secureStorage.write(key: 'pphoto', value: photo);
    } catch (e) {
      // Handle the error here, e.g., print or log the error
    }
  }

  Future<String?> getPhoto() async {
    try {
      return await _secureStorage.read(key: 'pphoto');
    } catch (e) {
      return null;
    }
  }

  Future<bool?> deletePhoto() async {
    try {
      await _secureStorage.delete(key: 'pphoto');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveBacklink(String link) async {
    try {
      await _secureStorage.write(key: 'backlink', value: link);
    } catch (e) {
      // Handle the error here, e.g., print or log the error
    }
  }

  Future<String?> getBacklink() async {
    try {
      return await _secureStorage.read(key: 'backlink');
    } catch (e) {
      return null;
    }
  }
}
