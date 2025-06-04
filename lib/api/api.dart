export 'base_api_service.dart';
export 'character_api_service.dart';
export 'novel_api_service.dart';
export 'user_api_service.dart';
export 'payment_api_service.dart';
export 'group_api_service.dart';

import 'base_api_service.dart';
import 'character_api_service.dart';
import 'novel_api_service.dart';
import 'user_api_service.dart';
import 'payment_api_service.dart';
import 'group_api_service.dart';

/// API 服务管理类
/// 统一管理所有 API 服务实例
class ApiService {
  /// 单例模式实例
  static final ApiService instance = ApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory ApiService() => instance;

  /// 私有构造函数，防止外部实例化
  ApiService._privateConstructor();

  /// 基础 API 服务
  final BaseApiService base = BaseApiService.instance;

  /// 角色聊天 API 服务
  final CharacterApiService character = CharacterApiService.instance;

  /// 小说 API 服务
  final NovelApiService novel = NovelApiService.instance;

  /// 用户 API 服务
  final UserApiService user = UserApiService.instance;

  /// 支付 API 服务
  final PaymentApiService payment = PaymentApiService.instance;

  /// 群聊 API 服务
  final GroupApiService group = GroupApiService.instance;
}
