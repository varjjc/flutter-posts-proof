import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prueb_app/models/user.dart';
import 'package:prueb_app/providers/user_provider.dart';
import 'package:prueb_app/services/user_service.dart';

// Mock del UserService
class MockUserService extends Mock implements UserService {}

void main() {
  late UserProvider userProvider;
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
    userProvider = UserProvider(mockUserService);
  });

  group('UserProvider', () {
    test('loadUsers carga los usuarios correctamente', () async {
      // Configura el mock para devolver una lista de usuarios
      when(mockUserService.getUsers()).thenAnswer((_) async => [
            User(id: 1, name: 'Leanne Graham', email: 'leanne@example.com', phone: '123-456-7890'),
          ]);

      // Llama al método loadUsers
      await userProvider.loadUsers();

      // Verifica que los usuarios se cargaron correctamente
      expect(userProvider.users.length, 1);
      expect(userProvider.users[0].name, 'Leanne Graham');
    });

    test('loadUsers maneja errores correctamente', () async {
      // Configura el mock para lanzar una excepción
      when(mockUserService.getUsers()).thenThrow(Exception('Error de red'));

      // Llama al método loadUsers
      await userProvider.loadUsers();

      // Verifica que el estado de error se maneja correctamente
      expect(userProvider.users.isEmpty, true);
    });
  });
}