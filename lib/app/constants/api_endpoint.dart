// class ApiEndpoints {
//   ApiEndpoints._();

//   static const Duration connectionTimeout = Duration(seconds: 1000);
//   static const Duration receiveTimeout = Duration(seconds: 1000);
//   static const String baseUrl = "http://10.0.2.2:4000/api/";
//   // For iPhone
//   //static const String baseUrl = "http://localhost:3000/api/v1/";

//   // ====================== Auth Routes ======================
//   static const String login = "user/login";
//   static const String register = "user/register";
//   static const String station = "station/list";
//   static const String imageUrl = "http://10.0.2.2:4000/uploads/";
//   static const String uploadImage = "user/uploadImage";
// }
class ApiEndpoints {
  ApiEndpoints._(); // ✅ Private Constructor to prevent instantiation

  // ✅ Connection Timeouts
  static const Duration connectionTimeout =
      Duration(seconds: 10); // ⬅ Reduced from 1000
  static const Duration receiveTimeout =
      Duration(seconds: 10); // ⬅ Reduced from 1000

  // ✅ Base URLs
  static const String baseUrl = "http://10.0.2.2:4000/api/"; // Android Emulator
  static const String iosBaseUrl = "http://localhost:4000/api/"; // iOS/Mac

  // ✅ Auth Routes
  static const String login = "user/login";
  static const String register = "user/register";
  static const String profile = "user/get-profile";

  // ✅ Charging Station Routes
  static const String station = "station/list";

  // ✅ Image Upload
  static const String imageUrl = "http://172.26.0.153:4000/uploads/";
  static const String uploadImage = "user/uploadImage";
}
