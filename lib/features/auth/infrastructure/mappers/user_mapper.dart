import '../../domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> user) => User(
    id: user["id"],
    email: user["email"],
    fullname: user["fullName"],
    roles: List<String>.from(user["roles"].map((role) => role)),
    token: user["token"] ?? "",
  );

  static User userRegisterToEntity(Map<String, dynamic> register) => User(
    id: register["id"],
    email: register["email"],
    fullname: register["fullName"],
    roles: List<String>.from(register["roles"].map((role) => role)),
    token: register["token"] ?? "",
  );
}
