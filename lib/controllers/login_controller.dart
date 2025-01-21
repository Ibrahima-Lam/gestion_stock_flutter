import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/home/login.dart';
import 'package:gestion_stock_flutter/produit/produit_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ListString = List<String>;

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  var isSigningIn = false.obs;
  RxBool rememberMe = false.obs;
  final String key = 'user';

  Future navigateToProduitPage(BuildContext context) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ProduitPage()));
  }

  void setRememberMe(bool value) {
    rememberMe.value = value;
  }

  Future<ListString?> getUser() async {
    return CacheService.getList(key);
  }

  Future<void> setUser(ListString value) async {
    return CacheService.setList(key, value);
  }

  Future<bool> checkUser() async {
    ListString? value = await getUser();
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

  void setIsSigningIn(var newValue) {
    isSigningIn.value = newValue;
  }

  Future<void> login(BuildContext context,
      {required String email, required String password}) async {
    setIsSigningIn(true);
    UserCredential? userCredential = await _loginService.login(email, password);
    setIsSigningIn(false);
    if (userCredential != null) {
      navigateToProduitPage(context);
      print(userCredential.user!.email);
      if (rememberMe.value) {
        await CacheService.setList(key, [email, password]);
      } else {
        await CacheService.removeList(key);
      }
    } else {}
  }

  Future<void> logout(BuildContext context) async {
    await _loginService.logout();
    await CacheService.removeList(key);
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}

class LoginService {
  Future<UserCredential?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

class CacheService {
  static Future<void> setList(String key, ListString value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  static Future<ListString?> getList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ListString? value = prefs.getStringList(key);
    if (value == null || value.length < 2) {
      return null;
    }
    return value;
  }

  static Future<void> removeList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
