import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:test_project/add_user.dart';
import 'package:test_project/providers/providers.dart';
import 'package:test_project/update_user.dart';

import 'models/user_model.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<modelProvider>().getAllUser();
    });
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<modelProvider>(context, listen: false).getAllUser();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
        ),
        title: Text('Users'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: context.watch<modelProvider>().user_list.length,
            itemBuilder: (context, index) {
              userModel user = context.watch<modelProvider>().user_list[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(user.image),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: " + user.name),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Email: " + user.email),
                      ],
                    ),
                    TextButton(
                        onPressed: () async {
                          var provider = Provider.of<modelProvider>(context,
                              listen: false);
                          provider.deleteUser(user.id!);
                        },
                        child: Text('delete')),
                    TextButton(
                        onPressed: () async {
                          var provider = Provider.of<modelProvider>(context,
                              listen: false);
                          await provider.set_user(user);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateUser()));
                        },
                        child: Text('update')),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUser()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
