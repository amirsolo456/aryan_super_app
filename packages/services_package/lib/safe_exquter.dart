
class SafeExqueter<T> {
  final dynamic value;
  final String errorMessage;

  SafeExqueter.fromString(this.value, {this.errorMessage = "Invalid string"});

  SafeExqueter.fromBool(this.value, {this.errorMessage = "Invalid bool"});

  SafeExqueter.fromInt(this.value, {this.errorMessage = "Invalid int"});

  SafeExqueter.fromHttpMethods(
      this.value, {
        this.errorMessage = "Invalid HttpMethod",
      });


  Future<T> execute(Future<T> Function(dynamic value) action) async {
    try {
      if (value == null) {
        // اگر خروجی جنریک T باید false باشه:
        if (T == bool) return false as T;
        throw Exception(errorMessage);
      }
      return await action(value);
    } catch (e) {
      if (T == bool) return false as T;
      rethrow;
    }
  }
}
