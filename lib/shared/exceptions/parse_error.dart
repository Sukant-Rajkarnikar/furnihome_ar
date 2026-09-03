import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:furnihome_ar/shared/exceptions/app_exception.dart';
import 'package:furnihome_ar/shared/network/errors.dart';
import 'package:furnihome_ar/utils/strings.dart';

String parseError(dynamic e) {
  if (e is TypeError) {
    return 'Error while parsing Data!';
  } else if (e is NetworkNotAvailableException) {
    return e.message ?? Strings.noInternetError;
  }
  else if (e is FailedResponseException) {
    return e.message ?? Strings.somethingWentWrong;
  } else if (e.toString().contains("SocketException")) {
    return Strings.noInternetError;
  } else if (e is DioException) {
    var customMessage = getCustomMessage(e);
    return _handleStatusCode(e.response?.statusCode, customMessage);
  } else if (e is AppException) {
    return e.message;
  }
  else {
    return 'Oops something went wrong!';
  }
}

String getCustomMessage(e) {
  var message = 'Error! something went wrong';
  var errorMsg = e.response?.data['errors']?[0]?['message'];
  if (errorMsg != null && errorMsg.toString().isNotEmpty) {
    message = errorMsg;
  } else {
    message = e.response?.data['errors']?['message'];
  }
  return message;
}

String _handleStatusCode(int? statusCode, String? message) {
  debugPrint("DIO ERROR:==============> $statusCode MSG: $message");
  switch (statusCode) {
    case 400:
      return 'Bad request.';
    case 500:
      return 'Internal server error.';
    default:
      return 'Oops something went wrong!';
  }
}