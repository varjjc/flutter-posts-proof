import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/models/posts.dart';
import 'package:prueb_app/providers/user_provider.dart';
import 'package:prueb_app/screens/user_detail_screen.dart';

class MockUserProvider extends Mock implements UserProvider {}

void main() {
  final mockUser = User(
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    phone: '123-456-7890',
  );

  final mockPosts = [
    Post(id: 1, userId: 1, title: 'Test Title', body: 'Test Body'),
  ];

  testWidgets('Muestra datos del usuario y publicaciones', (tester) async {
    final mockProvider = MockUserProvider();
    when(mockProvider.getPostsByUserId(any)).thenAnswer((_) async => mockPosts);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: mockProvider),
        ],
        child: MaterialApp(
          home: UserDetailScreen(user: mockUser),
        ),
      ),
    );

    // Verifica datos del usuario
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Teléfono: 123-456-7890'), findsOneWidget);
    expect(find.text('Email: john@example.com'), findsOneWidget);

    // Verifica publicaciones
    await tester.pumpAndSettle();
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Body'), findsOneWidget);
  });

  testWidgets('Muestra mensaje de error', (tester) async {
    final mockProvider = MockUserProvider();
    when(mockProvider.getPostsByUserId(any)).thenThrow('Error');

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: mockProvider),
        ],
        child: MaterialApp(
          home: UserDetailScreen(user: mockUser),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Error al cargar las publicaciones'), findsOneWidget);
  });
}