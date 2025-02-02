import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/providers/user_provider.dart';
import 'package:prueb_app/services/user_service.dart';
import 'package:prueb_app/repositories/user_repository.dart';

class MockUserService extends Mock implements UserService {}
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserProvider userProvider;
  late MockUserService mockUserService;
  late MockUserRepository mockUserRepository;

  final mockUsers = [
    User(id: 1, name: 'John', email: 'john@test.com', phone: '123'),
  ];

  setUp(() {
    mockUserService = MockUserService();
    mockUserRepository = MockUserRepository();
    userProvider = UserProvider(mockUserService);
  });

  test('loadUsers() carga usuarios desde el repositorio', () async {
    when(mockUserRepository.getUsers()).thenAnswer((_) async => mockUsers);

    await userProvider.loadUsers();
    expect(userProvider.users, mockUsers);
    verify(mockUserRepository.getUsers()).called(1);
  });

  test('loadUsers() carga desde el servicio si el repositorio está vacío', () async {
    when(mockUserRepository.getUsers()).thenAnswer((_) async => []);
    when(mockUserService.getUsers()).thenAnswer((_) async => mockUsers);
    when(mockUserRepository.saveUsers(any)).thenAnswer((_) async => true);

    await userProvider.loadUsers();
    expect(userProvider.users, mockUsers);
    verify(mockUserService.getUsers()).called(1);
    verify(mockUserRepository.saveUsers(mockUsers)).called(1);
  });

  test('getPostsByUserId() retorna posts del servicio', () async {
    final mockPosts = [Post(id: 1, userId: 1, title: 'Test', body: 'Test')];
    when(mockUserService.getPostsByUserId(any)).thenAnswer((_) async => mockPosts);

    final result = await userProvider.getPostsByUserId(1);
    expect(result, mockPosts);
    verify(mockUserService.getPostsByUserId(1)).called(1);
  });
}