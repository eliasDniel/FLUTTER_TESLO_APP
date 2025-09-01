import 'package:dio/dio.dart';
import 'package:flutter_teslo_app/config/config.dart';

import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthDatasourcesImpl implements AuthDataSources {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));
  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      return UserMapper.userJsonToEntity(loginResponse);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) throw ConnectionTimeout();
      if (e.response?.statusCode == 401) throw WrongCredentials();
      throw CustomError('Unknown error', e.response?.statusCode ?? 500);
    } catch (e) {
      throw CustomError('Unknown error', 500);
    }
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
