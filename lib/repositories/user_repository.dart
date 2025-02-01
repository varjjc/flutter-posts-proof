import 'dart:convert';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRepository {
  final String _usersKey = 'users';

  Future<void> saveUsers(List<User> users) async{
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList(_usersKey, usersJson);
  }


  

  Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersKey) ?? [];
    final users = usersJson.map((json) => User.fromJson(jsonDecode(json))).toList();
    return users;
  }
}


