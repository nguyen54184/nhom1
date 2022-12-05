import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:kthp_moblie/model/buyer.dart';
import 'package:kthp_moblie/model/product.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';


part 'buyer.service.g.dart';

@RestApi(baseUrl: "http://localhost:3000/v1/api/buyer")
abstract class RestBuyer {
  factory RestBuyer(Dio dio, {String baseUrl}) = _RestBuyer;

  @GET("/getForUser/{id}")
  Future<List<Product>> getBuyers(@Path("id") String id);

  @POST("/createBuyer")
  Future<CreateBuyer> createBuyer(@Body() Buyer buyer);
}

@JsonSerializable()
class CreateBuyer {
  Buyer? buyer;
  bool? status;

  CreateBuyer({this.buyer, this.status});

  factory CreateBuyer.fromJson(Map<String, dynamic> json) => _$CreateBuyerFromJson(json);

}
