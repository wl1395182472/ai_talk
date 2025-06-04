class UiStyle {
  /// 私有构造函数，防止外部直接实例化
  UiStyle._privateConstructor();

  /// 单例实例
  static final instance = UiStyle._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory UiStyle() {
    return instance;
  }

  final animatedDuration = Duration(milliseconds: 200);
}
