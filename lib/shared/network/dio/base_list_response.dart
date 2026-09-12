class BaseListResponse<T> {
  String status;
  String? error;
  List<T>? data;
  int? count;
  int? limit;
  int? offset;

  BaseListResponse({
    required this.status,
    this.data,
    this.error,
    this.count,
    this.limit,
    this.offset,
  });

  factory BaseListResponse.fromJson(
      Map<String, dynamic> json, Function(List<dynamic>) build) {
    return BaseListResponse<T>(
      status: json["status"],
      data: json["data"] != null ? build(json["data"]) : null,
      error: json["error"]?.toString(),
      count: json["count"],
      limit: json["limit"],
      offset: json["offset"],
    );
  }
}