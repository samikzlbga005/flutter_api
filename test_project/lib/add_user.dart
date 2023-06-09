import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/providers.dart';
import 'models/user_model.dart';

class AddUser extends StatefulWidget {
  AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUser();
}

class _AddUser extends State<AddUser> {
  TextEditingController name = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");
  String image = "";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    image = Faker().image.image(random: true).toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                  if (name.text == null && email.text == null) {
                  } else {
                    var provider =
                        Provider.of<modelProvider>(context, listen: false);
                    await provider.setUser(name.text, email.text, image);
                    name.text = "";
                    email.text = "";
                    Navigator.pop(context);
                  }
                }, 'Add User')
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
