import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sprint4_fix/app/constants/hive_table_contant.dart';
import 'package:sprint4_fix/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.customerTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? customerId;
  @HiveField(1)
  final String fname;
  @HiveField(2)
  final String lname;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String name;
  @HiveField(8)
  final String password;

  AuthHiveModel({
    String? customerId,
    required this.fname,
    required this.lname,
    this.image,
    required this.email,
    required this.name,
    required this.password,
  }) : customerId = customerId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : customerId = '',
        fname = '',
        lname = '',
        image = '',
        email = '',
        name = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      customerId: entity.userId,
      fname: entity.fname,
      lname: entity.lname,
      image: entity.image,
      email: entity.email,
      name: entity.name,
      password: entity.password,
    );
  }

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

  @override
  List<Object?> get props => [customerId, fname, lname, image, name, password];
}
