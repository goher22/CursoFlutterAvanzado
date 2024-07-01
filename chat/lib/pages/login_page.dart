import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import '../widgets/button_blue.dart';
import '../widgets/custom_input.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(
                  title: "Messenger",
                ),
                _Form(),
                const Labels(
                  ruta: "register",
                  title: "¿No tienes cuenta?",
                  subtitle: "Crea una ahora!",
                ),
                const Text(
                  "Términos y condiciones de uso",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormStateState();
}

class __FormStateState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: "Correo",
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: "Contraseña",
            textController: passwordController,
            isPassword: true,
          ),
          ButtonBlue(
            text: 'Ingrese',
            onPressed: authService.authentication
                ? null
                : () async {
                    try {
                      FocusScope.of(context).unfocus();
                      await authService.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    } catch (e) {
                      showAlert(context, "Login incorrecto",
                          "Revise sus credenciales");
                    }
                  },
          ),
        ],
      ),
    );
  }
}
