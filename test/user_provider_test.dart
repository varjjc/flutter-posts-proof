import 'package:flutter_test/flutter_test.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/models/posts.dart';
import 'package:prueb_app/providers/user_provider.dart';
import 'package:prueb_app/services/user_service.dart';
import 'package:prueb_app/repositories/user_repository.dart';


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
  late FakeUserRepository fakeUserRepository;
  setUp(() {
    fakeUserService = FakeUserService();
    fakeUserRepository = FakeUserRepository();
    provider = UserProvider(fakeUserService, fakeUserRepository);
    
  });

  test('Carga usuarios correctamente desde el servicio', () async {
    await provider.loadUsers();


    print('Usuarios cargados: ${provider.users.length}');
    expect(provider.users.length, 1);
    expect(provider.users[0].name, 'Fake User');
  });
}
