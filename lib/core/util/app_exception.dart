// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppException implements Exception {
  final String message;
  String? statusCode;

  AppException({required this.message, this.statusCode});

  AppException copyWith({String? message, String? statusCode}) {
    return AppException(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'message': message, 'statusCode': statusCode};
  }

  factory AppException.fromMap(Map<String, dynamic> map) {
    return AppException(
      message: map['message'] as String,
      statusCode: map['statusCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppException.fromJson(String source) =>
      AppException.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppException(message: $message, statusCode: $statusCode)';

  @override
  bool operator ==(covariant AppException other) {
    if (identical(this, other)) return true;
    return other.message == message && other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}
