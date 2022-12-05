// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBuyer _$CreateBuyerFromJson(Map<String, dynamic> json) => CreateBuyer(
      buyer: json['buyer'] == null
          ? null
          : Buyer.fromJson(json['buyer'] as Map<String, dynamic>),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$CreateBuyerToJson(CreateBuyer instance) =>
    <String, dynamic>{
      'buyer': instance.buyer,
      'status': instance.status,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestBuyer implements RestBuyer {
  _RestBuyer(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:3000/v1/api/buyer';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Product>> getBuyers(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Product>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/getForUser/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<CreateBuyer> createBuyer(buyer) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(buyer.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CreateBuyer>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/createBuyer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateBuyer.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
