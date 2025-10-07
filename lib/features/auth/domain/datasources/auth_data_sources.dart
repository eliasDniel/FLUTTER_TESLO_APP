


import '../domain.dart';

abstract class AuthDataSources {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullname);
  Future<User> checkStatus( String token );

}