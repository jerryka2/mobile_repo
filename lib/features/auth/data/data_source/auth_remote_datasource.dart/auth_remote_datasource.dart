import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sprint4_fix/app/constants/api_endpoint.dart';
import 'package:sprint4_fix/features/auth/data/data_source/auth_data_source.dart';
import 'package:sprint4_fix/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<String> logincustomer(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> registercustomer(AuthEntity customer) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          // 'fName': customer.fname,
          // 'lName': customer.lname,
          'name': customer.name,
          'email': customer.email,
          'password': customer.password,
          'image': customer.image,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
