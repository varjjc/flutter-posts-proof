import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:prueb_app/services/user_service.dart';
import 'package:prueb_app/widgets/user_card.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/screens/user_detail_screen.dart';
import 'package:prueb_app/providers/user_provider.dart';

void main() {
  testWidgets('UserCard se muestra correctamente y navega a UserDetailScreen', (WidgetTester tester) async {
    // Crear un usuario de prueba
    final user = User(id: 1, name: 'John Doe', email: 'johndoe@example.com', phone: '123-456-7890');

    // Crear un UserProvider falso
    final fakeUserProvider = UserProvider(UserService());

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: fakeUserProvider),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: UserCard(user: user),
          ),
        ),
      ),
    );

    // Verificar que el nombre, email y teléfono se muestran correctamente
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('E-mail: johndoe@example.com'), findsOneWidget);
    expect(find.text('Teléfono: 123-456-7890'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

    // Simular el tap en la tarjeta
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    // Verificar que se ha navegado a UserDetailScreen
    expect(find.byType(UserDetailScreen), findsOneWidget);
  });
}
