// class AuthRemoteRepository implements IAuthRepository {
//   final AuthRemoteDatasource _authRemoteDatasource;

//   AuthRemoteRepository(this._authRemoteDatasource);

//   @override
//   Future<Either<Failure, AuthEntity>> getCurrentUser() {
//     // TODO: implement getCurrentUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, String>> logincustomer(
//       String username, String password) async {
//     try {
//       final token =
//           await _authRemoteDatasource.logincustomer(username, password);
//       return Right(token);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> registercustomer(AuthEntity customer) async {
//     try {
//       await _authRemoteDatasource.registercustomer(customer);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadProfilePicture(File file) async {
//     try {
//       final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
//       return Right(imageName);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
// }
