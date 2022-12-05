import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:kthp_moblie/model/login.dart';
import 'package:kthp_moblie/model/register.dart';
import 'package:kthp_moblie/model/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth.g.dart';

@RestApi(baseUrl: "http://localhost:3000/v1/api/auth")
abstract class RestLoginAuth {
  factory RestLoginAuth(Dio dio, {String baseUrl}) = _RestLoginAuth;

  @POST("/login")
  Future<LoginAuth> loginAuth(@Body() Login login);

  @POST("/register")
  Future<RegisterAuth> registerAuth(@Body() Register register);

}

@JsonSerializable()
class LoginAuth {
  String? message;
  User? user;
  bool? status;

  LoginAuth({this.message, this.user, this.status});

  factory LoginAuth.fromJson(Map<String, dynamic> json) => _$LoginAuthFromJson(json);
  Map<String, dynamic> toJson() => _$LoginAuthToJson(this);
}

@JsonSerializable()
class RegisterAuth {
  String? message;
  User? user;
  bool? status;

  RegisterAuth({this.message, this.user, this.status});

  factory RegisterAuth.fromJson(Map<String, dynamic> json) => _$RegisterAuthFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterAuthToJson(this);
}