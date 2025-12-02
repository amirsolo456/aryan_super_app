

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';

Future<LoginRequest?> getToken() async {
  final prefs = await SharedPreferences.getInstance();

  String? jsonString = prefs.getString("user_token");

  if (jsonString == null) return null;

  return LoginRequest.fromJson(jsonDecode(jsonString));
}
