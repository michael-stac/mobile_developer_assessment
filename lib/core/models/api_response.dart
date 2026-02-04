import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  @JsonKey(name: 'statusCode')
  final int statusCode;

  final String message;

  final List<ApiError>? errors;

  final T? data;

  const ApiResponse({
    required this.statusCode,
    required this.message,
    this.errors,
    this.data,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  bool get hasErrors => errors != null && errors!.isNotEmpty;

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  @override
  String toString() {
    return 'ApiResponse{statusCode: $statusCode, message: $message, hasErrors: $hasErrors}';
  }
}

@JsonSerializable()
class ApiError {
  final String errorCode;
  final String message;

  const ApiError({
    required this.errorCode,
    required this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  @override
  String toString() => 'ApiError{errorCode: $errorCode, message: $message}';
}