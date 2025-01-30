import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sprint4_fix/core/error/failure.dart';
import 'package:sprint4_fix/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registercustomer(AuthEntity customer);

  Future<Either<Failure, String>> logincustomer(
      String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
