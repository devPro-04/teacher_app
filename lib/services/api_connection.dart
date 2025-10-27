import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:olinom/Models/mission_history.dart';
import 'package:olinom/Models/notification_model.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/sesssion_item.dart';
import '../Models/mission_model.dart';

class ApiConnection {
  static const String apiUrl = "https://devfront.olinom.com/api";
  final _localStorage = LocalStorage();
  late Dio dio;
  static String description = 'Notes';

  ApiConnection() {
    dio = Dio();
    dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true));
    /*final httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final SecurityContext securityContext = SecurityContext();
        // Add your trusted certificates
        securityContext.setTrustedCertificatesBytes(File('assets/certificates.pem').readAsBytesSync());
        return HttpClient(context: securityContext);
      },
    );
    dio.httpClientAdapter = httpClientAdapter;*/
    final httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(context: SecurityContext());
        // For development only - bypass certificate verification
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );

    dio.httpClientAdapter = httpClientAdapter;
    dio.options.connectTimeout = const Duration(seconds: 50);
    dio.options.receiveTimeout = const Duration(seconds: 50);
  }

  Future<String> loginCheck(String email, String password) async {
    try {
      final data = {
        "username": email,
        "password": password,
      };
      final response = await dio.post('$apiUrl/login_check',
          data: data,
          options: Options(headers: {'Accept': 'application/json'}));

      if (response.data is Map && response.data.containsKey('token')) {
        final token = response.data['token'];
        await _localStorage.saveJwtToken(token);
        await _localStorage.saveCredentials(email, password);
        return 'Connexion réussie';
      } else {
        return response.data['message'] ?? "could not connect to server";
      }
    } catch (err) {
      return 'An unknown error occurred!';
    }
  }

  Future<bool> userProfile() async {
    try {
      var jwtToken = await _localStorage.getJwtToken();

      final response1 = await dio.get('$apiUrl/auth_valid',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response1.statusCode == 200) {
        final photo = response1.data['data']['photo'];
        final fullname = response1.data['data']['full_name'];

        await _localStorage.saveFullname(fullname);
        await _localStorage.savePhoto(photo);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> reconnectOnline() async {
    try {
      Map<String, String?> credentials = await _localStorage.getCredentials();
      final email = credentials['email'];
      final password = credentials['password'];

      if (email == null || password == null) {
        return false;
      }
      final data = {
        "username": email,
        "password": password,
      };
      final response = await dio.post(
        '$apiUrl/login_check',
        data: data,
      );
      if (response.data is Map && response.data.containsKey('token')) {
        final token = response.data['token'];
        await _localStorage.saveJwtToken(token);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<dynamic> getWelcomeExpectedAnswer() async {
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/replacement/expectedanswer',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        if ((response.data['data']) is List) {
          return 0;
        } else {
          return response.data['data'];
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> getWelcomeTotalWeekSession() async {
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/replacement/totalweeksession',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        if ((response.data['data']) is List) {
          return 0;
        } else {
          return response.data['data'];
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> getMessageRequests(searchtext) async {
    try {
      final data = {
        "searchtext": searchtext,
      };
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.post('$apiUrl/campus/prof/messagerie/list',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: data);
      if (response.statusCode == 200) {
        final Future<dynamic> data = Future.value(response.data['data']);

        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> getMessageClasses(rrid) async {
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get(
          '$apiUrl/campus/prof/messagerie/classes/$rrid',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        final Future<dynamic> data = Future.value(response.data['data']);

        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> getMessageChat(rid) async {
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/campus/prof/messagerie/chat/$rid',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        final Future<dynamic> data = Future.value(response.data['data']);

        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> createMessage(
      int idConversation,
      int sessionid,
      int idAccountEstab,
      String pathEstablishment,
      int replacementid,
      String msgcontent) async {
    await reconnectOnline();
    try {
      final data = {
        "idConversation": idConversation,
        "idAccountEstab": idAccountEstab,
        "pathEstablishment": pathEstablishment,
        "sessionid": sessionid,
        "idReplacement": replacementid,
        "content": msgcontent,
      };
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.post(
          '$apiUrl/campus/prof/messagerie/conversation/message/new/campus/$idConversation',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: data);
      if (response.statusCode == 200 &&
          response.data['data']['isSend'] == true) {
        return true;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on DioException {
      return false;
    }
  }

  Future<dynamic> updatepricereplacement(List<int> sessions, int priceprof,
      int idlevel, int idreplacement, String isProfIsProfEtab) async {
    await reconnectOnline();
    try {
      final data = {
        "sessions": sessions,
        "priceprof": priceprof,
        "idlevel": idlevel,
        "idreplacement": idreplacement,
        "isProfIsProfEtab": isProfIsProfEtab,
      };
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.post(
          '$apiUrl/replacement/update/price/instructor',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: data);
      if (response.statusCode == 200) {
        final Future<dynamic> data = Future.value(response.data['data']);
        return data;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  // Future<List> getWelcomeMission2() async {
  //   try {
  //     var jwtToken = await _localStorage.getJwtToken();
  //     final response = await dio.get(
  //         '$apiUrl/replacement/welcomereplacementlist',
  //         options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
  //     if (response.statusCode == 200) {
  //       // Extract sessionsdates from response data
  //       final List data = response.data['data'];
  //       // return data.map((json) => MissionModel.fromJson(json)).toList();
  //       return data;
  //     } else {
  //       throw Exception('Failed to fetch data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  Future<List<MissionModel>> getWelcomeMission() async {
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get(
          '$apiUrl/replacement/welcomereplacementlist',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        // Extract sessionsdates from response data
        final List<dynamic> data = response.data['data'];
        return data.map((json) => MissionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<SessionModel>> getWelcomeWeekSessions() async {
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/replacement/weeksessions',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        // Extract sessionsdates from response data
        final List<dynamic> data = response.data['data'];
        return data.map((json) => SessionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<MissionModel>> getMissionsList() async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/replacement/list',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => MissionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<MissionModel> getOneMission(int id) async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();
      if (jwtToken == null || jwtToken.isEmpty) {
        throw Exception('No valid JWT token found');
      }

      final response = await dio.get('$apiUrl/replacement/detail/$id',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }

        if (response.data['data'] == null) {
          throw Exception('Response data.data is null');
        }

        final Map<String, dynamic> data = response.data['data'];
        // Check if required fields exist
        if (!data.containsKey('replacementid')) {
          throw Exception('Missing replacementid in response');
        }

        final mission = MissionModel.fromJsonMission(data);
        return mission;
      } else {
        throw Exception(
            'HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (dioError) {
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');
        case DioExceptionType.badResponse:
          throw Exception('Server error: ${dioError.response?.statusCode}');
        default:
          throw Exception('Network error: ${dioError.message}');
      }
    } catch (e, stackTrace) {
      throw Exception('Failed to fetch mission: $e');
    }
  }

  Future<List<MissionHistory>> getMissionHistory() async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/replacement/history',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }

        if (response.data['data'] == null) {
          throw Exception('Response data.data is null');
        }

        final List<dynamic> data = response.data['data'];
        return data.map((json) => MissionHistory.fromJson(json)).toList();
      } else {
        throw Exception(
            'HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (dioError) {
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');
        case DioExceptionType.badResponse:
          throw Exception('Server error: ${dioError.response?.statusCode}');
        default:
          throw Exception('Network error: ${dioError.message}');
      }
    } catch (e, stackTrace) {
      throw Exception('Failed to fetch session item: $e');
    }
  }

  Future<List<SessionItem>> getOneMissionSessionDates(int id) async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();

      final response = await dio.get('$apiUrl/replacement/sessiondates/$id',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }

        if (response.data['data'] == null) {
          throw Exception('Response data.data is null');
        }

        // Check if required fields exist
        final List<dynamic> data = response.data['data'];
        return data.map((json) => SessionItem.fromJson(json)).toList();
      } else {
        throw Exception(
            'HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (dioError) {
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');
        case DioExceptionType.badResponse:
          throw Exception('Server error: ${dioError.response?.statusCode}');
        default:
          throw Exception('Network error: ${dioError.message}');
      }
    } catch (e, stackTrace) {
      throw Exception('Failed to fetch session item: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMission(int id) async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/replacement/detail/$id',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        // Extract sessionsdates from response data
        description = response.data['data']['description'];
        var sessions = response.data['data']['sessionsdates'] as List;
        // Map the sessions to a list of maps containing only begindatetime and enddatetime dates
        var sessionDates = sessions.map((session) {
          return {
            'begindatetime': session['begindatetime']['date'],
            'enddatetime': session['enddatetime']['date'],
            'description': session['desctiption'],
          };
        }).toList();
        return sessionDates;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<NotificationModel>> getNotification() async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get('$apiUrl/replacement/notifications',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<SessionModel>> getSessions() async {
    await reconnectOnline();
    try {
      final list = await getMissionsList();
      var jwtToken = await _localStorage.getJwtToken();

      List<SessionModel> allSessions = []; // Accumulator for all sessions

      for (int i = 0; i < list.length; i++) {
        final response = await dio.get(
            '$apiUrl/replacement/${list[i].replacementId}/sessions/list',
            options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));

        if (response.statusCode == 200) {
          final List<dynamic> data = response.data['data'];
          List<SessionModel> sessionsForMission =
              data.map((json) => SessionModel.fromJson(json)).toList();
          allSessions.addAll(sessionsForMission); // Add sessions to accumulator
        } else {
          throw Exception('Failed to fetch data for mission ${list[i]}');
        }
      }
      return allSessions; // Return all accumulated sessions
    } catch (e, stackTrace) {
      throw Exception('Failed to fetch session item: $e');
    }
  }

  Future<bool> acceptMission(
      int replacementid, int levelid, List<dynamic> sessionids) async {
    await reconnectOnline();
    try {
      final data = {
        "replacementid": replacementid,
        "levelid": levelid,
        "sessions": sessionids
      };
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.post('$apiUrl/replacement/accept',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: data);
      if (response.statusCode == 200 &&
          response.data['data']['success'] == true) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  Future<bool> rejectMission(int replacementid, int levelid) async {
    await reconnectOnline();
    try {
      final data = {
        "replacementid": replacementid,
        "levelid": levelid,
      };
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.post('$apiUrl/replacement/reject',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: data);
      if (response.statusCode == 200 &&
          response.data['data']['success'] == true) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  Future<bool> rejectSession(int sessionid, String reason) async {
    await reconnectOnline();
    try {
      final data = {
        "id": sessionid,
        "reason": reason,
      };
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.post('$apiUrl/replacement/session/cancel',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: data);
      if (response.statusCode == 200 &&
          response.data['data']['success'] == true) {
        return true;
      } else {
        return false;
      }
    } on DioException {
      return false;
    }
  }

  Future<SessionModel> getOneSession(int replacementid, int sessionid) async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get(
          '$apiUrl/replacement/$replacementid/session/$sessionid',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        // Extract sessionsdates from response data
        final Map<String, dynamic> data = response.data['data'];
        // Check if required fields exist
        if (!data.containsKey('replacementid')) {
          throw Exception('Missing replacementid in response');
        }

        final mission = SessionModel.fromJsonSession(data);
        return mission;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on DioException catch (dioError) {
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout');
        case DioExceptionType.badResponse:
          throw Exception('Server error: ${dioError.response?.statusCode}');
        default:
          throw Exception('Network error: ${dioError.message}');
      }
    } catch (e, stackTrace) {
      throw Exception('Failed to fetch session item: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getSessionReports(
      int replacementid) async {
    await reconnectOnline();
    try {
      var jwtToken = await _localStorage.getJwtToken();
      final response = await dio.get(
          '$apiUrl/replacement/$replacementid/sessions/reports/list',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      if (response.statusCode == 200) {
        // Extract sessionsdates from response data
        var reports = response.data['data'] as List;
        // Map the sessions to a list of maps containing only begindatetime and enddatetime dates
        var sessionDates = reports.map((session) {
          return {
            'sessiondate': session['sessiondate'],
            'report': session['report'],
          };
        }).toList();
        return sessionDates;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
