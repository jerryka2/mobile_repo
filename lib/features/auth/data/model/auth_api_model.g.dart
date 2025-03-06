// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      customerId: json['_customerid'] as String?,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_customerid': instance.customerId,
      'fname': instance.fname,
      'lname': instance.lname,
      'image': instance.image,
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
    };
