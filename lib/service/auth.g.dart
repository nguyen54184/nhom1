// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAuth _$LoginAuthFromJson(Map<String, dynamic> json) => LoginAuth(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$LoginAuthToJson(LoginAuth instance) => <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'status': instance.status,
    };

RegisterAuth _$RegisterAuthFromJson(Map<String, dynamic> json) => RegisterAuth(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$RegisterAuthToJson(RegisterAuth instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'status': instance.status,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestLoginAuth implements RestLoginAuth {
  _RestLoginAuth(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:3000/v1/api/auth';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginAuth> loginAuth(login) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(login.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginAuth>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginAuth.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterAuth> registerAuth(register) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(register.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<RegisterAuth>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterAuth.fromJson(_result.data!);
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
