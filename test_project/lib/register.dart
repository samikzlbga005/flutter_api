import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  late TextEditingController username;
  late TextEditingController password;
  @override
  void initState() {
    super.initState();
    username = TextEditingController(text: "samikzlbg44@gmail.com");
    password = TextEditingController(text: "12345678");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textfield(username, "Username"),
              SizedBox(
                height: 20,
              ),
              _textfield(password, "Password"),
              SizedBox(
                height: 30,
              ),
              _button_filed(() async {
                try {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  UserCredential credential =
                      await auth.createUserWithEmailAndPassword(
                          email: username.text, password: password.text);
                  print(credential);
                } catch (e) {
                  print(e.toString());
                }
              }, 'Register')
            ],
          ),
        ),
      ),
    );
  }

  Widget _textfield(TextEditingController controller, String label) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      );

  Widget _button_filed(Function() onPressed, String text) => TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.blue, fontSize: 20),
      ));
}
