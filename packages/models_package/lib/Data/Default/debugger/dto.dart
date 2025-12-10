


//Ehsan Change

class DebuggerModel {
  final String? className;
  final String? methodName;
  final String? status;
  final String? debugPlaceType;
  final String? time;
  final double? execMiliSec;
  final String? info1;
  final String? query;

  const DebuggerModel({
    this.className,
    this.methodName,
    this.status,
    this.debugPlaceType,
    this.time,
    this.execMiliSec,
    this.info1,
    this.query,
  });

  factory DebuggerModel.fromJson(Map<String, dynamic> json) {
    // ExecMiliSec ممکنه عدد یا رشته باشه؛ این‌جا هر دو حالت رو هندل می‌کنیم
    double? parseExec(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) {
        return double.tryParse(v);
      }
      return null;
    }

    return DebuggerModel(
      className: json['ClassName'] as String?,
      methodName: json['MethodName'] as String?,
      status: json['Status'] as String?,
      debugPlaceType: json['DebugPlaceType'] as String?,
      time: json['Time'] as String?,
      execMiliSec: parseExec(json['ExecMiliSec']),
      info1: json['Info1'] as String?,
      query: json['Query'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'ClassName': className,
    'MethodName': methodName,
    'Status': status,
    'DebugPlaceType': debugPlaceType,
    'Time': time,
    'ExecMiliSec': execMiliSec,
    'Info1': info1,
    'Query': query,
  };
}
