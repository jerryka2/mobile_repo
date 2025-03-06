import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/core/error/failure.dart';
import 'package:sprint4_fix/features/auth/domain/use_case/login_usecase.dart';

import '../repository/auth_repo.mock.dart';
import '../repository/token.mock.dart';

void main() {
  late AuthRepoMock repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase usecase;

  setUp(() {
    repository = AuthRepoMock();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUseCase(repository, tokenSharedPrefs);

    registerFallbackValue(const LoginParams(email: '', password: ''));

    // Mock getToken to return a valid token
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right('mocked_token'));

    // Mock saveToken to return a successful response
    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(''));
  });

  test(
      'should call the [AuthRepo.login] with correct email and password (kirtan, 1234)',
      () async {
    when(() => repository.logincustomer(any(), any())).thenAnswer(
      (invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (email == 'suman' && password == '1234') {
          return const Right('token');
        } else {
          return Left(ApiFailure(message: 'Invalid email or password'));
        }
      },
    );

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(''));

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right('mocked_token'));

    final result = await usecase(const LoginParams(
      email: 'suman',
      password: '1234',
    ));

    expect(result, const Right('token'));

    verify(() => repository.logincustomer('suman', '1234')).called(1);
    verify(() => tokenSharedPrefs.saveToken('token')).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
