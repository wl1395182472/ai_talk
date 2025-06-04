import '../model/api_response.dart';
import '../service/http_service.dart';
import '../service/user_service.dart';

/// PayPal 订单模型
class PayPalOrder {
  final String orderId;
  final String status;
  final List<PayPalLink> links;

  const PayPalOrder({
    required this.orderId,
    required this.status,
    required this.links,
  });

  factory PayPalOrder.fromJson(Map<String, dynamic> json) {
    return PayPalOrder(
      orderId: json['id'] as String,
      status: json['status'] as String,
      links: (json['links'] as List)
          .map((item) => PayPalLink.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': orderId,
      'status': status,
      'links': links.map((link) => link.toJson()).toList(),
    };
  }
}

/// PayPal 链接模型
class PayPalLink {
  final String href;
  final String rel;
  final String method;

  const PayPalLink({
    required this.href,
    required this.rel,
    required this.method,
  });

  factory PayPalLink.fromJson(Map<String, dynamic> json) {
    return PayPalLink(
      href: json['href'] as String,
      rel: json['rel'] as String,
      method: json['method'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'href': href,
      'rel': rel,
      'method': method,
    };
  }
}

/// PayPal 订阅模型
class PayPalSubscription {
  final String subscriptionId;
  final String status;
  final List<PayPalLink> links;

  const PayPalSubscription({
    required this.subscriptionId,
    required this.status,
    required this.links,
  });

  factory PayPalSubscription.fromJson(Map<String, dynamic> json) {
    return PayPalSubscription(
      subscriptionId: json['id'] as String,
      status: json['status'] as String,
      links: (json['links'] as List)
          .map((item) => PayPalLink.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': subscriptionId,
      'status': status,
      'links': links.map((link) => link.toJson()).toList(),
    };
  }
}

/// 创建订单请求模型
class CreateOrderRequest {
  final String productId;
  final double amount;
  final String currency;
  final String? description;

  const CreateOrderRequest({
    required this.productId,
    required this.amount,
    required this.currency,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': UserService.instance.userId,
      'product_id': productId,
      'amount': amount,
      'currency': currency,
      'description': description,
    };
  }
}

/// 创建订阅请求模型
class CreateSubscriptionRequest {
  final String planId;
  final String? description;

  const CreateSubscriptionRequest({
    required this.planId,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': UserService.instance.userId,
      'plan_id': planId,
      'description': description,
    };
  }
}

/// 支付相关 API 服务类
class PaymentApiService {
  /// 单例模式实例
  static final PaymentApiService instance =
      PaymentApiService._privateConstructor();

  /// 工厂构造函数，返回单例实例
  factory PaymentApiService() => instance;

  /// 私有构造函数，防止外部实例化
  PaymentApiService._privateConstructor();

  final HttpService _httpService = HttpService.instance;

  /// 5.1 创建 PayPal 订单
  Future<ApiResponse<PayPalOrder>> createPayPalOrder(
    CreateOrderRequest request,
  ) async {
    try {
      final response = await _httpService.post(
        '/api/paypal/createOrder',
        data: request.toJson(),
        fromJsonT: (data) => PayPalOrder.fromJson(data),
      );

      return ApiResponse<PayPalOrder>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('创建 PayPal 订单失败: $e');
    }
  }

  /// 5.2 创建 PayPal 订阅
  Future<ApiResponse<PayPalSubscription>> createPayPalSubscription(
    CreateSubscriptionRequest request,
  ) async {
    try {
      final response = await _httpService.post(
        '/api/paypal/createSubscription',
        data: request.toJson(),
        fromJsonT: (data) => PayPalSubscription.fromJson(data),
      );

      return ApiResponse<PayPalSubscription>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('创建 PayPal 订阅失败: $e');
    }
  }

  /// 5.4 捕获订单
  Future<ApiResponse<PayPalOrder>> capturePayPalOrder({
    required String orderId,
  }) async {
    try {
      final response = await _httpService.post(
        '/api/paypal/captureOrder',
        data: {
          'user_id': UserService.instance.userId,
          'order_id': orderId,
        },
        fromJsonT: (data) => PayPalOrder.fromJson(data),
      );

      return ApiResponse<PayPalOrder>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('捕获 PayPal 订单失败: $e');
    }
  }

  /// 取消订阅（根据接口文档推测）
  Future<ApiResponse<void>> cancelPayPalSubscription({
    required String subscriptionId,
    String? reason,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'subscription_id': subscriptionId,
        if (reason != null) 'reason': reason,
      };

      final response = await _httpService.post(
        '/api/paypal/cancelSubscription',
        data: data,
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('取消 PayPal 订阅失败: $e');
    }
  }

  /// 获取订阅详情（根据接口文档推测）
  Future<ApiResponse<PayPalSubscription>> getPayPalSubscription({
    required String subscriptionId,
  }) async {
    try {
      final response = await _httpService.post(
        '/api/paypal/getSubscription',
        data: {
          'user_id': UserService.instance.userId,
          'subscription_id': subscriptionId,
        },
        fromJsonT: (data) => PayPalSubscription.fromJson(data),
      );

      return ApiResponse<PayPalSubscription>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取 PayPal 订阅详情失败: $e');
    }
  }

  /// 获取用户的支付历史（根据接口文档推测）
  Future<ApiResponse<List<PayPalOrder>>> getPaymentHistory({
    int? limit,
    int? pageNo,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        if (limit != null) 'limit': limit,
        if (pageNo != null) 'page_no': pageNo,
      };

      final response = await _httpService.post(
        '/api/paypal/getPaymentHistory',
        data: data,
        fromJsonT: (data) =>
            (data as List).map((item) => PayPalOrder.fromJson(item)).toList(),
      );

      return ApiResponse<List<PayPalOrder>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取支付历史失败: $e');
    }
  }

  /// 获取用户的订阅列表（根据接口文档推测）
  Future<ApiResponse<List<PayPalSubscription>>> getSubscriptionList({
    String? status, // ACTIVE, CANCELLED, SUSPENDED
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        if (status != null) 'status': status,
      };

      final response = await _httpService.post(
        '/api/paypal/getSubscriptionList',
        data: data,
        fromJsonT: (data) => (data as List)
            .map((item) => PayPalSubscription.fromJson(item))
            .toList(),
      );

      return ApiResponse<List<PayPalSubscription>>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('获取订阅列表失败: $e');
    }
  }

  /// 验证支付（根据接口文档推测）
  Future<ApiResponse<bool>> verifyPayment({
    required String transactionId,
    required String paymentMethod, // paypal, stripe, apple_pay, google_pay
  }) async {
    try {
      final response = await _httpService.post(
        '/api/payment/verify',
        data: {
          'user_id': UserService.instance.userId,
          'transaction_id': transactionId,
          'payment_method': paymentMethod,
        },
        fromJsonT: (data) => data as bool,
      );

      return ApiResponse<bool>(
        code: response.code,
        msg: response.msg,
        result: response.result,
      );
    } catch (e) {
      throw Exception('验证支付失败: $e');
    }
  }

  /// 退款（根据接口文档推测）
  Future<ApiResponse<void>> requestRefund({
    required String transactionId,
    String? reason,
    double? amount,
  }) async {
    try {
      final data = {
        'user_id': UserService.instance.userId,
        'transaction_id': transactionId,
        if (reason != null) 'reason': reason,
        if (amount != null) 'amount': amount,
      };

      final response = await _httpService.post(
        '/api/payment/refund',
        data: data,
      );

      return ApiResponse<void>(
        code: response.code,
        msg: response.msg,
        result: null,
      );
    } catch (e) {
      throw Exception('申请退款失败: $e');
    }
  }
}
