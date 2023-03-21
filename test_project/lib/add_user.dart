import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/providers.dart';

import 'models/user_model.dart';

class AddUser extends StatefulWidget {
  userModel? user;
  AddUser({super.key, this.user});

  @override
  State<AddUser> createState() => _AddUser();
}

class _AddUser extends State<AddUser> {
  late TextEditingController name;
  late TextEditingController email;
  late String image;

  @override
  void initState() {
    // TODO: implement initState
    name = widget.user == null
        ? TextEditingController(text: "")
        : TextEditingController(text: widget.user!.name);
    email = widget.user == null
        ? TextEditingController(text: "")
        : TextEditingController(text: widget.user!.email);
    image = widget.user == null
        ? Faker().image.image(random: true).toString()
        : widget.user!.image.toString();
    super.initState();

    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<modelProvider>(context, listen: false).getAllUser();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                widget.user == null
                    ? _button_filed(() async {
                        if (name.text == null && email.text == null) {
                        } else {
                          var provider = Provider.of<modelProvider>(context,
                              listen: false);
                          await provider.setUser(name.text, email.text, image);
                          name.text = "";
                          email.text = "";
                        }
                      }, 'Add User')
                    : _button_filed(() async {
                        if (name.text == null && email.text == null) {
                        } else {
                          widget.user!.name = name.text;
                          widget.user!.email = email.text;
                          widget.user!.image = image.toString();
                          var provider = Provider.of<modelProvider>(context,
                              listen: false);
                          await provider.updateUser(widget.user!);
                        }
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
