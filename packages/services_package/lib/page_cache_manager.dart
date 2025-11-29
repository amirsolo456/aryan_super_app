import 'package:flutter/material.dart';

class PageCacheItem {
  final Widget page;
  DateTime lastAccess;

  PageCacheItem(this.page) : lastAccess = DateTime.now();

  void touch() {
    lastAccess = DateTime.now();
  }
}

class PageCacheManager {
  final Map<int, PageCacheItem> _cache = {};
  final Duration maxAge;

  PageCacheManager({this.maxAge = const Duration(minutes: 5)});

  Widget getOrCreate(int index, Widget Function() builder) {
    try {
      if (_cache.containsKey(index)) {
        _cache[index]!.touch();
        return _cache[index]!.page;
      }
      final page = builder();
      _cache[index] = PageCacheItem(page);
      return page;
    }
    catch (e) {
      print(e);
      return const SizedBox();
    }
  }

  void cleanCacheExcept(int currentIndex) {
    try {
      final now = DateTime.now();

      final toRemove = <int>[];

      _cache.forEach((index, item) {
        if (index == currentIndex) return;

        final age = now.difference(item.lastAccess);
        if (age > maxAge) {
          toRemove.add(index);
        }
      });

      for (var index in toRemove) {
        _cache.remove(index);
      }
    } catch (e) {
      print(e);
    }
  }
}
