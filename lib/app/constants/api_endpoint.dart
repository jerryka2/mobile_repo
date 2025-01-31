class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "https://10.0.2.2:3000/api/v1/";

  // ======================== Auth Endpoints ========================

  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const imageUrl = "htttps://10.0.2.2:3000/uploads/";
  static const String UploadImage = "auth/uploadImage";
}
