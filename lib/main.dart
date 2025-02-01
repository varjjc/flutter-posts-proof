import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueb_app/services/user_service.dart';
import './providers/user_provider.dart';
import './screens/user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(UserService())),
      ],
      child: MaterialApp(
        title: 'Flutter User Posts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserListScreen(),
      ),
    );
  }
}