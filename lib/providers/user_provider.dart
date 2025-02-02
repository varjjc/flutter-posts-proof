import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/posts.dart';
import '../services/user_service.dart';
import '../repositories/user_repository.dart';

class UserProvider with ChangeNotifier{

  final UserService _userService;

  UserProvider(this._userService);

  
  final UserRepository _userRepository = UserRepository();

  List<User> _users = [];
  List<User> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();  

    try {
      _users = await _userRepository.getUsers();
      if (_users.isEmpty) {
        
        _users = await _userService.getUsers();
        await _userRepository.saveUsers(_users);
      }
    } catch (e) {
      'Failed to load users: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Post>> getPostsByUserId(int userId) async {
    return await _userService.getPostsByUserId(userId);
  }
}