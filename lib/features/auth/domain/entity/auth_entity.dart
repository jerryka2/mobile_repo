import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final String username;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [userId, fname, lname, image, phone, username, password];
}
