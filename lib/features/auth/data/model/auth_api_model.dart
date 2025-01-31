import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprint4_fix/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_customerid')
  final String? customerId;
  final String fName;
  final String lName;
  final String? image;
  final String phone;
  final String username;
  final String password;

  const AuthApiModel({
    this.customerId,
    required this.fName,
    required this.lName,
    required this.image,
    required this.phone,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity

  AuthEntity toEntity() {
    return AuthEntity(
      userId: customerId,
      fName: fName,
      lName: lName,
      image: image,
      phone: phone,
      username: username,
      password: password,
    );
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      customerId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      phone: entity.phone,
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [customerId, fName, lName, image, phone, username, password];
}
