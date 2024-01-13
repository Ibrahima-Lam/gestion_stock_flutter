import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/controllers/login_controller.dart';
import 'package:gestion_stock_flutter/widget/text_field_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  LoginController controller = LoginController();

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFieldWidget(
                  hintText: "Email",
                  obscure: false,
                  controller: emailEditingController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFieldWidget(
                  hintText: 'Password',
                  obscure: true,
                  controller: passwordEditingController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => controller.isSigningIn.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        controller.login(context, emailEditingController.text,
                            passwordEditingController.text);
                      },
                      child: Container(
                          child: Text(
                        "Connexion",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))))
            ]),
          ),
        ),
      ),
    );
  }
}
