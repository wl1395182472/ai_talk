import 'dart:io';

import '../model/api_response.dart';
import '../service/http_service.dart';
import '../service/user_service.dart';
import '../util/log.dart';

/// 全局 API 服务类
/// 封装了应用中的全局性网络请求方法
/// 包括用户信息、支付相关、系统配置等接口
class GlobalApiService {
  /// 单例模式实例
  static final GlobalApiService instance =
      GlobalApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory GlobalApiService() => instance;

  /// 私有构造函数，防止外部实例化
  GlobalApiService._privateConstructor();

  final HttpService _httpService = HttpService.instance;

  /// 获取当前应用版本信息
  Future<ApiResponse<Map<String, dynamic>>> fetchAppVersion() async {
    try {
      final response = await _httpService.get(
        '/global/app_version',
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取应用版本信息失败: $e');
    }
  }

  /// 获取用户可见的完整标签列表
  ///
  /// 参数:
  /// - [includeLanguage] 是否包含语言信息
  ///
  /// 返回:
  /// - [ApiResponse] 包含标签列表数据的API响应对象
  Future<ApiResponse<List<Map<String, dynamic>>>> getCompleteTagsList({
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/global/tags',
        data: {
          'user_id': UserService.instance.userId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data.cast<Map<String, dynamic>>();
          } else {
            Log.instance.logger.w('获取标签列表返回的数据格式不正确: [${data.runtimeType}]');
            return <Map<String, dynamic>>[];
          }
        },
      );

      return ApiResponse<List<Map<String, dynamic>>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取标签列表失败: $e');
    }
  }

  /// 获取系统中所有可用的语音选项
  ///
  /// 返回:
  /// - [ApiResponse] 包含系统配置的所有可用语音选项的API响应对象
  Future<ApiResponse<List<Map<String, dynamic>>>> fetchAvailableVoices({
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/global/voices',
        data: {
          'user_id': UserService.instance.userId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data.cast<Map<String, dynamic>>();
          } else {
            Log.instance.logger.w('获取语音选项返回的数据格式不正确: [${data.runtimeType}]');
            return <Map<String, dynamic>>[];
          }
        },
      );

      return ApiResponse<List<Map<String, dynamic>>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取语音选项失败: $e');
    }
  }

  /// 获取支付相关的图片URL列表
  ///
  /// 返回:
  /// - [ApiResponse] 包含支付相关图片URL列表的API响应对象
  Future<ApiResponse<List<String>>> fetchPaymentImageUrls({
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/global/payment_images',
        data: {
          'user_id': UserService.instance.userId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data.cast<String>();
          } else {
            Log.instance.logger.w('获取支付图片URL返回的数据格式不正确: [${data.runtimeType}]');
            return <String>[];
          }
        },
      );

      return ApiResponse<List<String>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取支付图片URL失败: $e');
    }
  }

  /// 获取所有代币购买套餐选项
  ///
  /// 返回:
  /// - [ApiResponse] 包含所有代币购买套餐选项的API响应对象
  Future<ApiResponse<List<Map<String, dynamic>>>> getTokenPackages({
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/global/token_packages',
        data: {
          'user_id': UserService.instance.userId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data.cast<Map<String, dynamic>>();
          } else {
            Log.instance.logger.w('获取代币套餐返回的数据格式不正确: [${data.runtimeType}]');
            return <Map<String, dynamic>>[];
          }
        },
      );

      return ApiResponse<List<Map<String, dynamic>>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取代币套餐失败: $e');
    }
  }

  /// 获取所有VIP等级信息
  ///
  /// 返回:
  /// - [ApiResponse] 包含所有VIP等级信息的API响应对象
  Future<ApiResponse<List<Map<String, dynamic>>>> getVipLevels({
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/global/vip_levels',
        data: {
          'user_id': UserService.instance.userId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data.cast<Map<String, dynamic>>();
          } else {
            Log.instance.logger.w('获取VIP等级信息返回的数据格式不正确: [${data.runtimeType}]');
            return <Map<String, dynamic>>[];
          }
        },
      );

      return ApiResponse<List<Map<String, dynamic>>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取VIP等级信息失败: $e');
    }
  }

  /// 处理苹果内购购买
  ///
  /// 参数:
  /// - [receiptData] 苹果支付收据数据，包含交易详情
  ///
  /// 返回:
  /// - [ApiResponse] 包含购买处理结果的API响应对象
  Future<ApiResponse<Map<String, dynamic>>> handleApplePurchase({
    required String receiptData,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/apple/purchase',
        data: {
          'user_id': UserService.instance.userId,
          'receipt_data': receiptData,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('处理苹果内购失败: $e');
    }
  }

  /// 处理谷歌内购购买
  ///
  /// 参数:
  /// - [receiptData] 谷歌支付收据数据，包含交易详情
  ///
  /// 返回:
  /// - [ApiResponse] 包含购买处理结果的API响应对象
  Future<ApiResponse<Map<String, dynamic>>> handleGooglePurchase({
    required String receiptData,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/google/purchase',
        data: {
          'user_id': UserService.instance.userId,
          'receipt_data': receiptData,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('处理谷歌内购失败: $e');
    }
  }

  /// 查询用户的订阅状态
  ///
  /// 参数:
  /// - [paymentChannel] 支付渠道，例如：'apple'、'google'
  ///
  /// 返回:
  /// - [ApiResponse] 包含用户订阅状态信息的API响应对象
  Future<ApiResponse<Map<String, dynamic>>> getSubscriptionStatus({
    required String paymentChannel,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/subscription/status',
        data: {
          'user_id': UserService.instance.userId,
          'payment_channel': paymentChannel,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('查询订阅状态失败: $e');
    }
  }

  /// 创建Stripe订单
  ///
  /// 参数：
  /// - [packageId] Stripe 产品 ID（可选）
  /// - [characterId] 角色 ID（可选）
  /// - [storyId] 故事 ID（可选）
  /// - [worldId] 世界 ID（可选）
  /// - [novelId] 小说 ID（可选）
  /// - [groupId] 群组 ID（可选）
  ///
  /// 返回：
  /// - [ApiResponse] 包含创建的订单信息
  Future<ApiResponse<Map<String, dynamic>>> createStripeOrder({
    String? packageId,
    int? characterId,
    int? storyId,
    int? worldId,
    int? novelId,
    int? groupId,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/stripe/order',
        data: {
          'user_id': UserService.instance.userId,
          if (packageId != null) 'package_id': packageId,
          if (characterId != null) 'character_id': characterId,
          if (storyId != null) 'story_id': storyId,
          if (worldId != null) 'world_id': worldId,
          if (novelId != null) 'novel_id': novelId,
          if (groupId != null) 'group_id': groupId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('创建Stripe订单失败: $e');
    }
  }

  /// 订阅Stripe服务
  ///
  /// 参数：
  /// - [subscriptionLevel] 订阅等级（可选）
  /// - [characterId] 角色 ID（可选）
  /// - [storyId] 故事 ID（可选）
  /// - [worldId] 世界 ID（可选）
  /// - [novelId] 小说 ID（可选）
  /// - [groupId] 群组 ID（可选）
  ///
  /// 返回：
  /// - [ApiResponse] 包含订阅结果的信息
  Future<ApiResponse<Map<String, dynamic>>> subscribeStripeService({
    int? subscriptionLevel,
    int? characterId,
    int? storyId,
    int? worldId,
    int? novelId,
    int? groupId,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/stripe/subscribe',
        data: {
          'user_id': UserService.instance.userId,
          if (subscriptionLevel != null)
            'subscription_level': subscriptionLevel,
          if (characterId != null) 'character_id': characterId,
          if (storyId != null) 'story_id': storyId,
          if (worldId != null) 'world_id': worldId,
          if (novelId != null) 'novel_id': novelId,
          if (groupId != null) 'group_id': groupId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('订阅Stripe服务失败: $e');
    }
  }

  /// 检查Stripe ID的状态
  ///
  /// 参数：
  /// - [stripeId] Stripe 的 ID
  ///
  /// 返回：
  /// - [ApiResponse] 包含 ID 状态的信息
  Future<ApiResponse<Map<String, dynamic>>> checkStripeIdStatus({
    required String stripeId,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/stripe/status',
        data: {
          'user_id': UserService.instance.userId,
          'stripe_id': stripeId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('检查Stripe ID状态失败: $e');
    }
  }

  /// 获取Stripe代币购买配置文件
  ///
  /// 参数：
  /// - [packageId] 套餐 ID
  ///
  /// 返回：
  /// - [ApiResponse] 包含购买配置文件的信息
  Future<ApiResponse<Map<String, dynamic>>> getStripeTokenProfile({
    required String packageId,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/stripe/token/profile',
        data: {
          'user_id': UserService.instance.userId,
          'package_id': packageId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取Stripe代币配置失败: $e');
    }
  }

  /// 获取Stripe订阅配置文件
  ///
  /// 参数：
  /// - [subscriptionLevel] 订阅等级
  ///
  /// 返回：
  /// - [ApiResponse] 包含订阅配置文件的信息
  Future<ApiResponse<Map<String, dynamic>>> getStripeSubscriptionProfile({
    required int subscriptionLevel,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/stripe/subscription/profile',
        data: {
          'user_id': UserService.instance.userId,
          'subscription_level': subscriptionLevel,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取Stripe订阅配置失败: $e');
    }
  }

  /// 获取PayPal代币购买配置文件
  ///
  /// 参数：
  /// - [packageId] 套餐 ID
  ///
  /// 返回：
  /// - [ApiResponse] 包含购买配置文件的信息
  Future<ApiResponse<Map<String, dynamic>>> getPaypalTokenProfile({
    required String packageId,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/paypal/token/profile',
        data: {
          'user_id': UserService.instance.userId,
          'package_id': packageId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取PayPal代币配置失败: $e');
    }
  }

  /// 获取PayPal订阅配置文件
  ///
  /// 参数：
  /// - [subscriptionLevel] 订阅等级
  ///
  /// 返回：
  /// - [ApiResponse] 包含订阅配置文件的信息
  Future<ApiResponse<Map<String, dynamic>>> getPaypalSubscriptionProfile({
    required int subscriptionLevel,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/payment/paypal/subscription/profile',
        data: {
          'user_id': UserService.instance.userId,
          'subscription_level': subscriptionLevel,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as Map<String, dynamic>,
      );

      return ApiResponse<Map<String, dynamic>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取PayPal订阅配置失败: $e');
    }
  }

  /// 上传用户头像图片
  ///
  /// 参数:
  /// - [avatarImage] 头像图片文件
  ///
  /// 返回:
  /// - [ApiResponse] 包含头像上传结果的 API 响应对象
  Future<ApiResponse<String>> uploadUserAvatar({
    required File avatarImage,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.upload(
        '/user/upload_avatar',
        file: avatarImage,
        fileName: 'avatar.jpg',
        fileKey: 'avatar',
        extraData: {
          'user_id': UserService.instance.userId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as String,
      );

      return ApiResponse<String>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('上传用户头像失败: $e');
    }
  }

  /// 翻译文本内容
  ///
  /// 参数：
  /// - [sourceLanguage] 源语言，默认为 'auto'（可选）
  /// - [targetLanguage] 目标语言
  /// - [textContent] 要翻译的文本内容
  ///
  /// 返回：
  /// - [ApiResponse] 包含翻译结果的响应对象
  Future<ApiResponse<String>> translateText({
    String sourceLanguage = 'auto',
    required String targetLanguage,
    required String textContent,
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/global/translate',
        data: {
          'user_id': UserService.instance.userId,
          'source_language': sourceLanguage,
          'target_language': targetLanguage,
          'text_content': textContent,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) => data as String,
      );

      return ApiResponse<String>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('翻译文本失败: $e');
    }
  }

  /// 获取礼物列表
  Future<ApiResponse<List<Map<String, dynamic>>>> getGiftList({
    bool includeLanguage = true,
  }) async {
    try {
      final response = await _httpService.post(
        '/global/gifts',
        data: {
          'user_id': UserService.instance.userId,
          'include_language': includeLanguage,
        },
        fromJsonT: (data) {
          if (data is List) {
            return data.cast<Map<String, dynamic>>();
          } else {
            Log.instance.logger.w('获取礼物列表返回的数据格式不正确: [${data.runtimeType}]');
            return <Map<String, dynamic>>[];
          }
        },
      );

      return ApiResponse<List<Map<String, dynamic>>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取礼物列表失败: $e');
    }
  }
}
