import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_project/models/user_model.dart';

class Services {
  Uri getUrl(String endpoint) => Uri.parse(
      "https://testproject-fecfe-default-rtdb.europe-west1.firebasedatabase.app/" +
          endpoint +
          ".json");

  Future<List<userModel>> getUsers() async {
    http.Response response = await http.get(getUrl("users"));
    List<userModel> list = [];

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      for (var key in data.keys) {
        userModel user = userModel.fromMap(data[key])
          ..id = key; //user.id = key => demektir
        list.add(user);
      }
    }
    return list;
  }

  Future<userModel?> getUserById(String id) async {
    http.Response response = await http.get(getUrl("users/$id"));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      return userModel.fromJson(response.body)..id = id;
    } else {
      return null;
    }
  }

  Future<userModel?> postUser(userModel user) async {
    http.Response response = await http.post(getUrl("users"),
        body: user.toJson(), headers: {"Content-Type": "application/json"});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var data = json.decode(response.body);
        user.id = data["name"];
        return user;
    } 
    else {
      return null;
    }
  }

  Future<bool> updateUser(userModel user) async {
    http.Response response = await http.put(getUrl("users/${user.id}"),
        body: user.toJson(), headers: {"Content-Type": "application/json"});
      
        return response.statusCode >= 200 && response.statusCode < 300;
    
  }

  Future<bool> deleteUser(String id) async {
     http.Response response = await http.delete(getUrl("users/$id"));
      
        return response.statusCode >= 200 && response.statusCode < 300;
  }
}
