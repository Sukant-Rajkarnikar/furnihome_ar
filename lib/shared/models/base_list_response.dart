class BaseListResponse<T> {
  int status;
  String? title;
  List<T>? data;
  String? error;
  String? message;

  BaseListResponse(
      {required this.status, this.title, this.data, this.message, this.error});

  factory BaseListResponse.fromJson(
      Map<String, dynamic> json, Function(List<dynamic>) build) {
    return BaseListResponse<T>(
        status: json["statusCode"],
        title: json["title"],
        error: json["error"],
        message: json["message"],
        data: build(json["data"]));
  }
}
