// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      customerId: json['_customerid'] as String?,
      fname: json['fName'] as String,
      lname: json['lName'] as String,
      image: json['image'] as String?,
      phone: json['phone'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_customerid': instance.customerId,
      'fName': instance.fname,
      'lName': instance.lname,
      'image': instance.image,
      'phone': instance.phone,
      'username': instance.username,
      'password': instance.password,
    };
