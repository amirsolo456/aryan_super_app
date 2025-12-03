class BaseResponse<D> {
  BaseResponse({
    this.result = "Failed",
    this.status,
    this.error,
    this.exception,
    this.data,
    this.additionalInfo,
    this.totalCount = 0,
    this.key,
  });

  String? result;
  int? status;
  String? error;
  Exception? exception;
  List<D>? data;
  String? additionalInfo;
  int totalCount;
  int? key;

  factory BaseResponse.error(Exception e) {
    return BaseResponse<D>(
      result: 'failed',
      status: 0,
      error: e.toString(),
      exception: Exception(e.toString()),
      data: [],
      additionalInfo: '',
      totalCount: 500,
      key: null,
    );
  }

  factory BaseResponse.success(String? message) {
    return BaseResponse<D>(result: "Success", error: message);
  }

  factory BaseResponse.fromjson(
    Map<String, dynamic> json, {
    D Function(Map<String, dynamic>)? fromDataJson,
  }) {
    List<D>? parsedData;

    try {
      if (json["Data"] != null && fromDataJson != null) {
        if (json["Data"] is List) {
          parsedData = (json["Data"] as List)
              .map((e) => fromDataJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      return BaseResponse<D>(
        data: parsedData,
        totalCount: json["TotalCount"],
        result: json["Failed"],
      );
    } catch (e) {
      return BaseResponse<D>(
        data: null,
        totalCount: json["TotalCount"],
        exception: Exception(e.toString()),
        result: json["Failed"],
      );
    }
  }
}
