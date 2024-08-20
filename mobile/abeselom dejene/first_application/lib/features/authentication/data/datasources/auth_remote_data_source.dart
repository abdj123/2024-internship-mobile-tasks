import 'dart:convert';

import 'package:first_application/features/authentication/data/models/user_model.dart';
import 'package:first_application/features/authentication/domain/entities/user.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';

abstract class UserRemoteDataSource {
  Future<String> loginUser(UserEntity userEntity, String password);
  Future<UserModel> registerUser(UserEntity userEntity, String password);
  Future<UserModel> getUser(String token);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser(String token) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(UserEntity userEntity, String password) async {
    try {
      final response = await client.post(Uri.parse(Urls.loginUrl),
          body: {'email': userEntity.email, 'password': password});

      if (response.statusCode == 201) {
        final token = json.decode(response.body);
        return token['data']['access_token'];
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> registerUser(UserEntity userEntity, String password) async {
    try {
      final response = await client.post(Uri.parse(Urls.registerUrl), body: {
        'email': userEntity.email,
        'name': userEntity.name,
        'password': password
      });

      if (response.statusCode == 201) {
        return UserModel.fromJsonRegiset(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
