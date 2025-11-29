class BaseResponse<T> {
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
  List<T>? data;
  String? additionalInfo;
  int totalCount;
  int? key;


  factory BaseResponse.error(Exception e, {String? message}) {
    return BaseResponse<T>(
      result: "Failed",
      error: message ?? e.toString(),
      exception: e,
    );
  }
}
