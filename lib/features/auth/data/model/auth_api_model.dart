import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprint4_fix/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_customerid')
  final String? customerId;
  final String fname;
  final String lname;
  final String? image;
  final String email;
  final String name;
  final String password;

  const AuthApiModel({
    this.customerId,
    required this.fname,
    required this.lname,
    required this.image,
    required this.email,
    required this.name,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity

  AuthEntity toEntity() {
    return AuthEntity(
      userId: customerId,
      fname: fname,
      lname: lname,
      image: image,
      email: email,
      name: name,
      password: password,
    );
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      customerId: entity.userId,
      fname: entity.fname,
      lname: entity.lname,
      image: entity.image,
      email: entity.email,
      name: entity.name,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [customerId, fname, lname, image, email, name, password];
}
