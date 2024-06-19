import 'package:flutter/material.dart';

import '../widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Logo(),
            _Form(),
            _Labels(),
            const Text(
              "Términos y condiciones de uso",
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: const Column(
          children: [
            Image(
              image: AssetImage("assets/tag-logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Messenger",
              style: TextStyle(fontSize: 30),
            ),
          ],
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
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: "Email",
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: "Password",
            textController: passwordController,
            isPassword: true,
          ),
          MaterialButton(onPressed: () {
            print(emailController.text);
            print(passwordController.text);
          }),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "¿No tienes cuenta?",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Crea una ahora!",
          style: TextStyle(
            color: Colors.blue[600],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
