import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_project/main.dart';
import 'package:test_project/register.dart';
import 'home_page.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                      await auth.signInWithEmailAndPassword(
                          email: username.text, password: password.text);

                  final User? firebaseUser = credential.user;

                  if (firebaseUser != null) {
                    print(firebaseUser.uid);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                  print(credential);
                } catch (e) {
                  print(e.toString());
                }
              }, 'Login'),
              _button_filed(() async {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Register(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }, 'Sign up'),
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
