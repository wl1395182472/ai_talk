/// API统一响应格式模型
///
/// 根据接口文档定义的统一返回数据格式：
/// - code: 状态码，0表示成功
/// - msg: 返回消息内容
/// - result: 具体数据内容
class ApiResponse<T> {
  /// 状态码，0表示成功
  final int code;

  /// 返回消息内容
  final String msg;

  /// 具体数据内容
  final T? result;

  const ApiResponse({
    required this.code,
    required this.msg,
    this.result,
  });

  /// 从JSON创建ApiResponse实例
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, [
    T Function(dynamic)? fromJsonT,
  ]) {
    final rawResult = json['result'];
    return ApiResponse<T>(
      code: json['code'] is int ? json['code'] : 0,
      msg: json['msg'] is String ? json['msg'] : '',
      result: rawResult != null && fromJsonT != null
          ? fromJsonT(rawResult)
          : (rawResult is T ? rawResult : null),
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson([Object? Function(T)? toJsonT]) {
    return {
      'code': code,
      'msg': msg,
      'result':
          result != null && toJsonT != null ? toJsonT(result as T) : result,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
