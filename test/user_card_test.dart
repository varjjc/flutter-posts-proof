import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/widgets/user_card.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockUser = User(
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    phone: '123-456-7890',
  );

  testWidgets('Muestra los datos del usuario correctamente', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserCard(user: mockUser),
        ),
      ),
    );

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('E-mail: john@example.com'), findsOneWidget);
    expect(find.text('Teléfono: 123-456-7890'), findsOneWidget);
  });

  testWidgets('Navega a UserDetailScreen al hacer tap', (tester) async {
    final mockObserver = MockNavigatorObserver();
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserCard(user: mockUser),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    await tester.tap(find.byType(UserCard));
    await tester.pumpAndSettle();

    // Verifica que se navegó a UserDetailScreen
    verify(() => mockObserver.didPush(any(), any())).called(1);
  });
}