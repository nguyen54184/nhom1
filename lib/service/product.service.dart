import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:kthp_moblie/model/product.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';


part 'product.service.g.dart';

@RestApi(baseUrl: "http://localhost:3000/v1/api/product")
abstract class RestProduct {
  factory RestProduct(Dio dio, {String baseUrl}) = _RestProduct;

  @GET("/")
  Future<List<Product>> getProducts();
}

@JsonSerializable()
class Product {
  String? id;
  String? productName;
  double? price;
  String? image;
  String? discription;

  Product({this.id, this.productName, this.price, this.image,this.discription});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
