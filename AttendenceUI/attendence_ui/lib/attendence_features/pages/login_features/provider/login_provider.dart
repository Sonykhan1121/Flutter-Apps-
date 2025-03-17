import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../services/UserService.dart';

class LoginProvier extends ChangeNotifier{
  final UserService _userService = UserService();
  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;


  Future<void> loginUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    http.Response response = await _userService.loginUser(email, password);
    _isLoading = false;

    switch (response.statusCode) {
      case 200:
        _message = "Authentication successful";
        break;
      case 401:
        _message = "Invalid username/password or User not found";
        break;
      case 403:
        _message = "User email verification required";
        break;
      case 404:
        _message = "User not found";
        break;
      case 500:
        _message = "Internal server error";
        break;
      default:
        _message = "Something went wrong";
    }

    notifyListeners();
  }
}