import 'package:flutter/material.dart';
import 'package:test_project/models/services/services.dart';
import 'package:test_project/models/user_model.dart';

class modelProvider extends ChangeNotifier {
  final _service = Services();
  List<userModel> _user_list = [];
  List<userModel> get user_list => _user_list;
  userModel? _newUser;
  userModel get newUser => _newUser!;

  bool isadd = false;

  set_user(userModel currentUser){
    _newUser = currentUser;
    notifyListeners();
  }


  Future<void> getAllUser() async {
    final response = await _service.getUsers();
    _user_list = response;

    notifyListeners();
  }

  Future<void> setUser(String name, String email, String image) async {
    userModel newUser = userModel(name: name, email: email, image: image);
    final response = await _service.postUser(newUser);
    _newUser = response;
    
    getAllUser();
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    final response = await _service.deleteUser(id);
    bool val = response;
    getAllUser();
    notifyListeners();
  }

  Future<void> updateUser(userModel user) async {
    final response = await _service.updateUser(user);

    getAllUser();
    notifyListeners();
  }
}
