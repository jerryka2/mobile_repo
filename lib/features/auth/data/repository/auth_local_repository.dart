import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sprint4_fix/core/error/failure.dart';
import 'package:sprint4_fix/features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import 'package:sprint4_fix/features/auth/domain/entity/auth_entity.dart';
import 'package:sprint4_fix/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logincustomer(
    String email,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.logincustomer(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registercustomer(AuthEntity customer) async {
    try {
      return Right(_authLocalDataSource.registercustomer(customer));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
