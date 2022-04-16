import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_library/models/user.dart';

class Preferences extends ChangeNotifier{
  Preferences() {
    getUser();
  }

  SharedPreferences? _preferences;

  static const _keyUser = 'user';
  static const myUser = User(bookmarks: []);

  _initializePrefs() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future _setUser(User user) async {
    await _initializePrefs();

    final json = jsonEncode(user.toJson());

    await _preferences?.setString(_keyUser, json);
    notifyListeners();
  }

  Future<User> getUser() async {
    await _initializePrefs();

    final json = _preferences?.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }

  void toggleBookmark(int bookId) async {
    User user = await getUser();
    if (await isBookmarked(bookId)) {
      log('Removing from bookmarks');
      _removeBookmark(bookId);
    } else {
      log('Adding to bookmarks');
      user.bookmarks!.add(bookId);
      _setUser(user);
    }
    notifyListeners();
  }

  void _removeBookmark(int bookId) async {
    final user = await getUser();
    user.bookmarks!.remove(bookId);
    _setUser(user);
  }

  Future<bool> isBookmarked(int bookId) async {
    final user = await getUser();
    return user.bookmarks!.contains(bookId);
  }
}
