class BaseResponse<T> {
  String? message;
  dynamic status;
  T? data;
  List<Errors>? errors;

  BaseResponse({this.message, this.status, this.data, this.errors});

  // Notice the fromJsonT function now accepts 'dynamic' json to handle both Maps and Lists
  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonT,
      ) {
    return BaseResponse<T>(
      message: json["message"],
      status: json["statusCode"],
      // Safely parse the generic data
      data: json["data"] != null ? fromJsonT(json["data"]) : null,
      // Safely map the list of errors
      errors: json["errors"] != null
          ? (json["errors"] as List).map((i) => Errors.fromJson(i)).toList()
          : null,
    );
  }
}

class Errors {
  String? message;

  Errors({this.message});

  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(message: json["message"]);
  }
}