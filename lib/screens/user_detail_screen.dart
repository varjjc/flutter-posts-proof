import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/posts.dart';
import '../providers/user_provider.dart';

class UserDetailScreen extends StatelessWidget{

  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(user.name),
      ),
      body: FutureBuilder<List<Post>>(
        future: userProvider.getPostsByUserId(user.id),
         builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError){
            return Center(child: Text('Error al cargar las publicaciones'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información de contacto',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Teléfono: ${user.phone}'),
                        SizedBox(height: 4),
                        Text('Email: ${user.email}'),
                      ],
                    ),
                  ),
                ),
                Center(child: Text('No hay publicaciones')),
              ],
            );
          } else {
            final posts = snapshot.data!;
            return Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información de contacto',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Teléfono: ${user.phone}'),
                        SizedBox(height: 4),
                        Text('Email: ${user.email}'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        color: index % 2 == 0 ? Colors.blue[50] : Colors.green[50],
                        margin: EdgeInsets.all(8.0),
                        elevation: 4.0,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Título: ${post.title}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(post.body),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}