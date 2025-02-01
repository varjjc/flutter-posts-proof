import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_card.dart';
import '../models/user.dart';




class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen>{
  final TextEditingController _searchController = TextEditingController();
  List<User> _filteredUsers=[];

  @override
  void initState() {
    super.initState();
    final userPorvider = Provider.of<UserProvider>(context, listen: false);
      userPorvider.loadUsers().then((_) {
        _filteredUsers = userPorvider.users;
      });
      _searchController.addListener(_filterUsers);
  }

  void _filterUsers (){
     final userProvider = Provider.of<UserProvider>(context, listen: false);
     final query  = _searchController.text.toLowerCase();

     setState(() {
       _filteredUsers = userProvider.users.where((user) => user.name.toLowerCase().contains(query)).toList();
     });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Lista de Usuarios'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar usuario',
                hintText: 'Ingresa un nombre',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                _filterUsers();
              },
            ),
          ),
          Expanded(
            child: userProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredUsers.isEmpty
                    ? Center(child: Text('No se encontraron usuarios'))
                    : ListView.builder(
                        itemCount: _filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = _filteredUsers[index];
                          return UserCard(user: user);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}