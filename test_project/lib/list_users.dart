import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/providers.dart';

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
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  //refresh page
                });
              },
              child: Text(
                "Refresh",
                style: TextStyle(color: Colors.black),
              )),
        ],
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
                  children: [
                    CircleAvatar(
                        child: Container(
                      child: Image.network(user.image),
                    ) //Image.network(user.image),
                        ),
                    SizedBox(
                      width: 15,
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
                          setState(() {});
                        },
                        child: Text('delete')),
                    TextButton(onPressed: () {}, child: Text('update')),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
