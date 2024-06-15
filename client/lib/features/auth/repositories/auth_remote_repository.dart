import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // ignore: non_constant_identifier_names
      final Response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/auth/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );

      final resBodyMap = jsonDecode(Response.body) as Map<String, dynamic>;
      if (Response.statusCode != 201) {
        return Left(
          AppFailure(
            resBodyMap['detail'],
          ),
        );
      }

      return Right(
        UserModel.fromMap(resBodyMap),
      );
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<AppFailure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      // ignore: non_constant_identifier_names
      final Response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final resBodyMap = jsonDecode(Response.body) as Map<String, dynamic>;
      if (Response.statusCode != 200) {
        return Left(
          AppFailure(
            resBodyMap['detail'],
          ),
        );
      }

      return Right(
        UserModel.fromMap(resBodyMap),
      );
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }
}
