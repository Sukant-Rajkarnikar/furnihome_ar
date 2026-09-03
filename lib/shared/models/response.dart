import 'package:furnihome_ar/shared/exceptions/app_exception.dart';
import 'package:furnihome_ar/shared/models/either.dart';

class Response {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  Response(
      {required this.statusCode, this.statusMessage, this.data = const {}});
  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

extension ResponseExtension on Response {
  Right<AppException, Response> get toRight => Right(this);
}