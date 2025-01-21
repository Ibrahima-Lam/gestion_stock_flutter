import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/controllers/login_controller.dart';
import 'package:gestion_stock_flutter/widget/text_field_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = LoginController();

  final TextEditingController emailEditingController = TextEditingController();

  final TextEditingController passwordEditingController =
      TextEditingController();
  @override
  initState() {
    controller.getUser().then((value) {
      print(value);
      if (value != null) {
        emailEditingController.text = value[0];
        passwordEditingController.text = value[1];
        controller.setRememberMe(true);
        controller.login(context, email: value[0], password: value[1]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.grey],
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(spacing: 10, children: [
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    width: 100,
                    height: 100,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Gestion de stock',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                TextFieldWidget(
                  hintText: "Email",
                  obscure: false,
                  controller: emailEditingController,
                ),
                TextFieldWidget(
                  hintText: 'Password',
                  obscure: true,
                  controller: passwordEditingController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 10,
                  children: [
                    const Text(
                      'Se souvenir de moi',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Obx(() => Checkbox(
                          activeColor: Colors.black,
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.setRememberMe(value ?? false);
                          },
                        )),
                  ],
                ),
                Obx(() => controller.isSigningIn.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () async {
                          controller.login(context,
                              email: emailEditingController.text,
                              password: passwordEditingController.text);
                        },
                        child: const Text(
                          "Connexion",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
