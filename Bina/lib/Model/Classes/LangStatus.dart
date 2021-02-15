import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangStatus {
  final lang_status = "LANG_STATUS";

  setLangName(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(lang_status, value);
  }

  Future<bool> getLangName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(lang_status) ?? false;
  }
}

class LangNameProvider with ChangeNotifier {
  LangStatus langNamePreferences = LangStatus();
  bool _LangName = false;

  bool get langName => _LangName;

  set langName(bool value) {
    _LangName = value;
    langNamePreferences.setLangName(value);
    notifyListeners();
  }
}
