import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../services/UserService.dart';


class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> addUser(User user) async {
    _isLoading = true;
    notifyListeners();

    http.Response response = await _userService.createUser(user);
    _isLoading = false;

    switch (response.statusCode) {
      case 201:
        _message = "User created successfully";
        break;
      case 400:
        _message = "Password cannot be empty or null";
        break;
      case 409:
        _message = "Email already exists";
        break;
      case 417:
        _message = "Verification email send failed";
        break;
      case 500:
        _message = "Unexpected server error";
        break;
      default:
        _message = "Something went wrong";
    }

    notifyListeners();
  }

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
  Future<void> verifyUser(String code) async
  {
    _isLoading = true;
    notifyListeners();
    http.Response response = await _userService.verifyAccount(code);
    _isLoading = false;

    if (response.statusCode == 200) {
      _message = "User verified succesfully";
    } else {
      _message  ="Verification failed. Please try again.";
    }
    notifyListeners();
  }

}
