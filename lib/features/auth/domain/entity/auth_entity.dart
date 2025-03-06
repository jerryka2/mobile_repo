import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fname;
  final String lname;
  final String? image;
  final String email;
  final String name;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fname,
    required this.lname,
    this.image,
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [userId, fname, lname, image, email, name, password];
}
