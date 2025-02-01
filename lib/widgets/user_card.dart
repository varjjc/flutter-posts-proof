import 'package:flutter/material.dart';
import 'package:prueb_app/screens/user_detail_screen.dart';
import '../models/user.dart';

class UserCard extends StatelessWidget{

  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
          children: [
            Text('E-mail: ${user.email}'), // Primer subtítulo (email)
            SizedBox(height: 4), // Espacio entre los subtítulos
            Text('Teléfono: ${user.phone}'), // Segundo subtítulo (teléfono)
          ],
        ),
        hoverColor: Colors.green,
        trailing: Icon(Icons.arrow_forward),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen(user: user),
          ),
          );
        },
      ),
    );
  }
}