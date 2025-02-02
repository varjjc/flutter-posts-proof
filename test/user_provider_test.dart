import 'package:flutter_test/flutter_test.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/models/posts.dart';
import 'package:prueb_app/providers/user_provider.dart';
import 'package:prueb_app/services/user_service.dart';
import 'package:prueb_app/repositories/user_repository.dart';

// FakeUserService: Simula la respuesta de la API de usuarios
class FakeUserService implements UserService {
  @override
  String get baseUrl => ''; // Implementación requerida

  @override
  Future<List<User>> getUsers() async {
    return [
      User(id: 1, name: 'Fake User', email: 'fake@test.com', phone: '000'),
    ];
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async => [];
}



// FakeUserRepository: Simula una base de datos local
class FakeUserRepository implements UserRepository {
  List<User> users = [];

  @override
  Future<List<User>> getUsers() async => users;

  @override
  Future<void> saveUsers(List<User> users) async {
    this.users = users;
  }
}

void main() {
  late UserProvider provider;
  late FakeUserService fakeUserService;

  setUp(() {
    fakeUserService = FakeUserService();
    provider = UserProvider(fakeUserService);
  });

  test('Carga usuarios correctamente desde el servicio', () async {
    await provider.loadUsers();
    print('Usuarios cargados: ${provider.users.length}'); // Depuración
    expect(provider.users.length, 1);
    expect(provider.users[0].name, 'Fake User');
  });
}
