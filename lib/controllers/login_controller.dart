import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/produit/produit_page.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  var isSigningIn = false.obs;

  void setIsSigningIn(var newValue) {
    isSigningIn.value = newValue;
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    setIsSigningIn(true);
    await _loginService.login(context, email, password);
    setIsSigningIn(false);
  }
}

class LoginService {
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(email + ' est connecté')));
      print(userCredential.user!.uid);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ProduitPage()));
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Echec connexion')));
    }
  }
}
