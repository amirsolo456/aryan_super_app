

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';


Future<void> saveToken(LoginRequest token) async {
  final prefs = await SharedPreferences.getInstance();

  String jsonString = jsonEncode(token.toJson());
  await prefs.setString("user_token", jsonString);

  print("TOKEN SAVED IN SHAREDPREFERENCES");
}