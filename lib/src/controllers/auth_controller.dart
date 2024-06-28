import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mad3_submission_1/src/enum/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();

  static AuthController get I => GetIt.instance<AuthController>();

  AuthState state = AuthState.unauthenticated;
  SimulatedAPI api = SimulatedAPI();
  SharedPreferences? _prefs;

  AuthController() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSessionFromPrefs();
  }

  void _loadSessionFromPrefs() {
    bool isLoggedIn = _prefs?.getBool('isLoggedIn') ?? false;
    state = isLoggedIn ? AuthState.authenticated : AuthState.unauthenticated;
    notifyListeners();
  }

  Future<void> login(String userName, String password) async {
    bool isLoggedIn = await api.login(userName, password);
    if (isLoggedIn) {
      state = AuthState.authenticated;
      await _prefs?.setBool('isLoggedIn', true);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 2));
    state = AuthState.unauthenticated;
    await _prefs?.remove('isLoggedIn');
    notifyListeners();
  }

  Future<void> loadSession() async {
    if (_prefs == null || !_prefs!.containsKey('isLoggedIn')) {
      await _initPrefs();
    }
    _loadSessionFromPrefs();
  }
}

class SimulatedAPI {
  Map<String, String> users = {"FelixFranz": "12345678ABCabc!"};

  Future<bool> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 4));
    if (users[userName] == null) throw Exception("User does not exist");
    if (users[userName] != password) {
      throw Exception("Password does not match!");
    }
    return users[userName] == password;
  }
}
