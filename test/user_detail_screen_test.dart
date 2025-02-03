import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/models/posts.dart';
import 'package:prueb_app/providers/user_provider.dart';
import 'package:prueb_app/screens/user_detail_screen.dart';
import 'package:prueb_app/services/user_service.dart';

import 'user_provider_test.dart';

class FakeUserProvider extends UserProvider {
  FakeUserProvider() : super(FakeUserService(), FakeUserRepository());

  @override
  Future<List<Post>> getPostsByUserId(int userId) async {
    return []; 
  }
}

void main() {
  late UserProvider userProvider;
  late User testUser;

  setUp(() {
    userProvider = UserProvider(FakeUserService(), FakeUserRepository());
    testUser = User(id: 1, name: "Test User", email: "test@example.com", phone: "123456789");
  });

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: ChangeNotifierProvider<UserProvider>.value(
        value: userProvider,
        child: child,
      ),
    );
  }

  testWidgets('Muestra la información del usuario correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(UserDetailScreen(user: testUser)));
    await tester.pumpAndSettle(); 

    expect(find.text("Test User"), findsOneWidget);
    expect(find.textContaining("Teléfono: 123456789"), findsOneWidget);
    expect(find.textContaining("Email: test@example.com"), findsOneWidget);
  });

testWidgets('Muestra "No hay publicaciones" cuando no hay posts', (WidgetTester tester) async {
  final fakeUserProvider = FakeUserProvider();

  await tester.pumpWidget(
    ChangeNotifierProvider<UserProvider>.value(
      value: fakeUserProvider,
      child: MaterialApp(
        home: UserDetailScreen(user: testUser),
      ),
    ),
  );
  await tester.pumpAndSettle(); // Esperar FutureBuilder

  expect(find.text("No hay publicaciones"), findsOneWidget);
});


  testWidgets('Muestra lista de publicaciones correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(UserDetailScreen(user: testUser)));
    await tester.pumpAndSettle();

    expect(find.textContaining("Título:"), findsWidgets);
  });
}


class FakeUserService implements UserService {
  @override
  String get baseUrl => '';

  @override
  Future<List<User>> getUsers() async {
    return [
      User(id: 1, name: 'Fake User', email: 'fake@test.com', phone: '000'),
    ];
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (userId == 1) {
      return [
        Post(userId: 1, id: 1, title: "Título: Post 1", body: "Contenido del post 1"),
        Post(userId: 1, id: 2, title: "Título: Post 2", body: "Contenido del post 2"),
      ];
    }
    return [];
  }
}
