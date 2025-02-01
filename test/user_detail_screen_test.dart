import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/models/posts.dart';
import 'package:prueb_app/providers/user_provider.dart';
import 'package:prueb_app/screens/user_detail_screen.dart';
import 'package:prueb_app/services/user_service.dart';

// Mock del UserService
class MockUserService extends Mock implements UserService {}

void main() {
  late MockUserService mockUserService;
  late UserProvider userProvider;

  setUp(() {
    mockUserService = MockUserService();
    userProvider = UserProvider(mockUserService);
  });

  testWidgets('UserDetailScreen muestra las publicaciones correctamente', (WidgetTester tester) async {
    // Crea un usuario de prueba
    final user = User(id: 1, name: 'Leanne Graham', email: 'leanne@example.com', phone: '123-456-7890');

    // Configura el mock para devolver una lista de publicaciones
    when(mockUserService.getPostsByUserId(user.id)).thenAnswer((_) async => [
          Post(id: 1, userId: 1, title: 'Publicación 1', body: 'Cuerpo de la publicación 1'),
          Post(id: 2, userId: 1, title: 'Publicación 2', body: 'Cuerpo de la publicación 2'),
        ]);

    // Renderiza la pantalla UserDetailScreen
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<UserProvider>(
          create: (_) => userProvider,
          child: UserDetailScreen(user: user),
        ),
      ),
    );

    // Espera a que se complete la carga de las publicaciones
    await tester.pumpAndSettle();

    // Verifica que las publicaciones se muestran correctamente
    expect(find.text('Publicación 1'), findsOneWidget);
    expect(find.text('Cuerpo de la publicación 1'), findsOneWidget);
    expect(find.text('Publicación 2'), findsOneWidget);
    expect(find.text('Cuerpo de la publicación 2'), findsOneWidget);
  });

  testWidgets('UserDetailScreen muestra un mensaje si no hay publicaciones', (WidgetTester tester) async {
    // Crea un usuario de prueba
    final user = User(id: 1, name: 'Leanne Graham', email: 'leanne@example.com', phone: '123-456-7890');

    // Configura el mock para devolver una lista vacía de publicaciones
    when(mockUserService.getPostsByUserId(user.id)).thenAnswer((_) async => []);

    // Renderiza la pantalla UserDetailScreen
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<UserProvider>(
          create: (_) => userProvider,
          child: UserDetailScreen(user: user),
        ),
      ),
    );

    // Espera a que se complete la carga de las publicaciones
    await tester.pumpAndSettle();

    // Verifica que se muestra el mensaje "No hay publicaciones"
    expect(find.text('No hay publicaciones'), findsOneWidget);
  });
}