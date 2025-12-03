
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';


Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("");
}