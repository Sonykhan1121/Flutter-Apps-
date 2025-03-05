import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

class UserService {


  static const String _baseUrl = 'https://grozziie.zjweiting.com:3091/Attendance-System-Management/api/dev/auth';

  Future<http.Response> loginUser(String email, String password) async {
    var url = Uri.parse('$_baseUrl/user/login');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: json.encode({
        'username': email,
        'password': password,
      }),
    );
    return response;
  }
  Future<http.Response> createUser(User user) async {
    String API = '$_baseUrl/user/create';
    var url = Uri.parse(API);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );
    return response;
  }
  Future<http.Response> verifyAccount(String code) async {
    String API = '$_baseUrl/verify/${code}/account';
    var url = Uri.parse(API);
    var response = await http.get(
      url,
      headers: <String, String>{
        'accept': 'application/json',
      },
    );
    return response;
  }

}
