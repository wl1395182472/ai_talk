import '../model/user.dart';
import 'storage_service.dart';

class UserService {
  /// 单例模式实例
  static final UserService instance = UserService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory UserService() => instance;

  /// 私有构造函数，防止外部实例化
  UserService._privateConstructor();

  int _userId = StorageService.instance.userId;
  int get userId => _userId;
  set userId(int value) {
    _userId = value;
    StorageService.instance.userId = value;
  }

  /// 获取当前缓存的用户信息
  User? get currentUser => StorageService.instance.getUser();

  /// 检查用户是否已登录
  bool get isLoggedIn => userId > 0;

  /// 清除用户数据
  void clearUserData() {
    userId = 0;
    StorageService.instance.clearUser();
  }
}
