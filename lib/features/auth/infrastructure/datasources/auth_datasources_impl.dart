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
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Revisar conexión');
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data['message'] ?? 'Credenciales invalidas',
        );
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullname) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {'fullName': fullname, 'email': email, 'password': password},
      );
      final user = UserMapper.userRegisterToEntity(response.data);
      return user;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Revisar conexión');
      }
      if (e.response?.statusCode == 400) {
        throw CustomError(
          'Correo ya registrado',
        );
      }
      throw CustomError('Error en el servidor');
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> checkStatus(String token) async{

   try {
     final response = await dio.get(
      '/auth/check-status',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),  
    );
    final user = UserMapper.userJsonToEntity(response.data);
    return user;
   } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Revisar conexión');
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data['message'] ?? 'Token no valido',
        );
      }
      throw CustomError('Error en el servidor');
    } catch (e) {
      throw Exception();
    }
   
  }
}
