import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/posts.dart';
import '../models/user.dart';

class UserService{
    final String baseUrl = 'https://jsonplaceholder.typicode.com/';

    Future<List<User>>getUsers() async{
      final response = await http.get(Uri.parse('$baseUrl/users'));
      if(response.statusCode == 200){
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      }  else {
        throw Exception('Failed to load users');
      }
    }

    Future<List<Post>> getPostsByUserId(int userId) async {
        final response = await http.get(Uri.parse('$baseUrl/posts?userId=$userId'));
        if(response.statusCode == 200){
            List<dynamic> data = json.decode(response.body);
            return data.map((json) => Post.fromJson(json)).toList();
        }else {
            throw Exception('Failed to load posts');
        }
    }
}