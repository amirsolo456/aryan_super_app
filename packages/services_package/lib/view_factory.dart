import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewFactory {
  static final GetIt _services = GetIt.instance;
  static final Map<String, View Function(Map<String, String> parameters)>
  _viewMap = {};

  static void register<T extends View>(String key) {
    try {
      _viewMap[key] = (_) => _services.get<T>();
    } catch (e) {
      debugPrint('Error in register: $e');
    }
  }

  static Widget create(String key, [Map<String, String>? parameters]) {
    try {
      final creator = _viewMap[key];
      if (creator == null) {
        return Text(
          'Unknown view: $key',
          style: const TextStyle(color: Colors.red),
        );
      }
      return creator(parameters ?? {});
    } catch (e) {
      debugPrint('Error in create: $e');
      return const SizedBox.shrink();
    }
  }

  static T getParamsByType<T>(Map<String, String> parameters) {
    final jsonString = jsonEncode(parameters);
    return jsonDecode(jsonString) as T;
  }
}
