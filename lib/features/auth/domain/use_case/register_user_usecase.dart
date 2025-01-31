import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sprint4_fix/app/use_case/use_case.dart';
import 'package:sprint4_fix/features/auth/domain/entity/auth_entity.dart';
import 'package:sprint4_fix/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/error/failure.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String phone;
  final String username;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.username,
    required this.password,
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.username,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [fname, lname, phone, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.fname,
      lName: params.lname,
      phone: params.phone,
      username: params.username,
      password: params.password,
      image: params.image,
    );
    return repository.registercustomer(authEntity);
  }
}
