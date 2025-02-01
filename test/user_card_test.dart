import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart'; // Importa el paquete provider
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/services/user_service.dart';
import 'package:prueb_app/widgets/user_card.dart';
import 'package:prueb_app/screens/user_detail_screen.dart';
import 'package:prueb_app/providers/user_provider.dart'; // Asegúrate de importar el provider correcto

void main() {
  final testUser = User(
    id: 1,
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '123-456-7890',
  );

  // Mock o instancia del UserProvider
  final userProvider = UserProvider(UserService()); // Asegúrate de que UserProvider tenga un constructor sin parámetros o proporciona los necesarios

  testWidgets('UserCard navigates to UserDetailScreen on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<UserProvider>.value(
            value: userProvider, // Proporciona el UserProvider
            child: UserCard(user: testUser),
          ),
        ),
      ),
    );

    // Simula un tap en el UserCard
    await tester.tap(find.byType(UserCard));
    await tester.pumpAndSettle(); // Espera a que se complete la animación de navegación

    // Verifica que la pantalla UserDetailScreen se ha abierto
    expect(find.byType(UserDetailScreen), findsOneWidget);
  });
}