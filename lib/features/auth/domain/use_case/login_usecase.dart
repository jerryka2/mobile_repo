import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sprint4_fix/app/shared_prefs/token_shared_prefs.dart';
import 'package:sprint4_fix/app/use_case/use_case.dart';
import 'package:sprint4_fix/core/error/failure.dart';
import 'package:sprint4_fix/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository
        .logincustomer(params.username, params.password)
        .then((value) {
      return value.fold((faliure) => Left(faliure), (token) {
        tokenSharedPrefs.saveToken(token);
        tokenSharedPrefs.getToken().then((value) {
          print(value);
        });
        return Right(token);
      });
    });
  }
}
