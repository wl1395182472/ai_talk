/// 上传文件响应模型
class UploadResponse {
  final String url;
  final String? filename;
  final int? size;

  const UploadResponse({
    required this.url,
    this.filename,
    this.size,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      url: json['url'] as String,
      filename: json['filename'] as String?,
      size: json['size'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'filename': filename,
      'size': size,
    };
  }
}

/// 翻译请求模型
class TranslateRequest {
  final int userId;
  final String srcLang;
  final String targetLang;
  final String message;

  const TranslateRequest({
    required this.userId,
    required this.srcLang,
    required this.targetLang,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'src_lang': srcLang,
      'target_lang': targetLang,
      'message': message,
    };
  }
}

/// 翻译响应模型
class TranslateResponse {
  final String translatedText;
  final String? detectedLang;

  const TranslateResponse({
    required this.translatedText,
    this.detectedLang,
  });

  factory TranslateResponse.fromJson(Map<String, dynamic> json) {
    return TranslateResponse(
      translatedText: json['translated_text'] as String,
      detectedLang: json['detected_lang'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translated_text': translatedText,
      'detected_lang': detectedLang,
    };
  }
}

/// 生成图片请求模型
class GenerateImageRequest {
  final int userId;
  final int sessionId;
  final String type; // chat/group chat
  final int isGif; // 0/1
  final int? fromApp;
  final int? system;
  final String? lang;

  const GenerateImageRequest({
    required this.userId,
    required this.sessionId,
    this.type = 'chat',
    required this.isGif,
    this.fromApp,
    this.system,
    this.lang,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'session_id': sessionId,
      'type': type,
      'is_gif': isGif,
      'from_app': fromApp,
      'system': system,
      'lang': lang,
    };
  }
}

/// 生成音频请求模型
class GenerateAudioRequest {
  final int userId;
  final int sessionId;
  final int uniqId;
  final String type; // chat/group chat
  final int? fromApp;
  final int? system;
  final String? lang;

  const GenerateAudioRequest({
    required this.userId,
    required this.sessionId,
    required this.uniqId,
    this.type = 'chat',
    this.fromApp,
    this.system,
    this.lang,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'session_id': sessionId,
      'uniq_id': uniqId,
      'type': type,
      'from_app': fromApp,
      'system': system,
      'lang': lang,
    };
  }
}

/// 查询任务请求模型
class QueryTaskRequest {
  final int userId;
  final String createId;
  final String taskType; // image/audio
  final String system;

  const QueryTaskRequest({
    required this.userId,
    required this.createId,
    required this.taskType,
    required this.system,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'create_id': createId,
      'task_type': taskType,
      'system': system,
    };
  }
}

/// 任务响应模型
class TaskResponse {
  final String status; // pending, completed, failed
  final String? result;
  final String? error;

  const TaskResponse({
    required this.status,
    this.result,
    this.error,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      status: json['status'] as String,
      result: json['result'] as String?,
      error: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'result': result,
      'error': error,
    };
  }
}
