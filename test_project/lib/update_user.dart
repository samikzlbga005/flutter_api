import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/user_model.dart';
import 'package:test_project/providers/providers.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController name = TextEditingController(text: "");
  late TextEditingController email = TextEditingController(text: "");
  String image = Faker().image.image();
  @override
  Widget build(BuildContext context) {
    name = TextEditingController(
        text: context.watch<modelProvider>().newUser.name);
    email = TextEditingController(
        text: context.watch<modelProvider>().newUser.email);
    image = context.watch<modelProvider>().newUser.image;

    userModel user = context.watch<modelProvider>().newUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textfield(name, "Name"),
                SizedBox(
                  height: 20,
                ),
                _textfield(email, "Email"),
                SizedBox(
                  height: 30,
                ),
                Image.network(image),
                _button_filed(() async {
                  user.name = name.text;
                  user.email = email.text;
                  user.image = image;
                  var provider =
                      Provider.of<modelProvider>(context, listen: false);
                  await provider.updateUser(user);
                  Navigator.pop(context);
                }, 'Update User'),
              ],
            ),
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
