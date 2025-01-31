// class UploadImageParams {
//   final File file;

//   const UploadImageParams({
//     required this.file,
//   });
// }

// class UploadImageUsecase
//     implements UsecaseWithParams<String, UploadImageParams> {
//   final IAuthRepository _repository;

//   UploadImageUsecase(this._repository);

//   @override
//   Future<Either<Failure, String>> call(UploadImageParams params) {
//     return _repository.uploadProfilePicture(params.file);
//   }
// }
