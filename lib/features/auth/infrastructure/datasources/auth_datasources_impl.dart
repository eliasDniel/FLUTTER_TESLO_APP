




import '../../domain/domain.dart';

class AuthDatasourcesImpl implements AuthDataSources {
  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password, String fullname) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User> checkStatus(String token) {
    // TODO: implement checkStatus
    throw UnimplementedError();
  }
}