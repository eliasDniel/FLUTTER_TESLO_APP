import '../../domain/domain.dart';
import '../models/models.dart';

class UserMapper {
  static User userJsonToEntity(LoginResponse login) => User(
    id: login.id,
    email: login.email,
    fullname: login.fullName,
    roles: login.roles,
    token: login.token,
  );

  static User userRegisterToEntity(RegisterResponse register) => User(
    id: register.id,
    email: register.email,
    fullname: register.fullName,
    roles: register.roles,
    token: register.token,
  );
}
