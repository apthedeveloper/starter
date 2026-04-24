import 'package:dio/dio.dart';
import 'package:starter_project/app/core/model/api_exception.dart';
import 'package:starter_project/bootstrap/env.dart';

enum HttpMethod { get, post, put, delete }

final class ApiClient {
  ApiClient._() {
    _dio =
        Dio(
            BaseOptions(
              baseUrl: Env.baseUrl,

              // Timeouts
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),

              // Redirect handling
              followRedirects: true,
              maxRedirects: 5,

              // Validate status codes
              validateStatus: (status) {
                return status != null && status < 500;
              },

              // Extra metadata (optional)
              extra: {'withCredentials': true},
            ),
          )
          ..interceptors.addAll([
            if (Env.enableLogging)
              LogInterceptor(
                request: true,
                requestBody: true,
                responseBody: true,
                error: true,
              ),
            InterceptorsWrapper(
              onRequest: (options, handler) {
                if (_token?.trim().isNotEmpty == true) {
                  options.headers['Authorization'] = 'Bearer $_token';
                }
                return handler.next(options);
              },
            ),
          ]);
  }

  static final instance = ApiClient._();
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  late final Dio _dio;

  Future<T> request<T>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic body,
    required T Function(dynamic json) parser,
    CancelToken? cancelToken,
    void Function(int sent, int total)? onProgress,
  }) async {
    try {
      Response response;

      final options = Options(
        method: method.name.toUpperCase(),
        headers: {..._dio.options.headers, ...?headers},
      );

      response = await _dio.request(
        path,
        data: body,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onProgress,
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw ApiException(
          response.data?["message"] ?? "Request failed",
          statusCode: response.statusCode,
        );
      }

      try {
        return parser(response.data);
      } catch (e, stack) {
        throw ApiException(
          "Failed to parse response",
          type: ApiErrorType.unknown,
          raw: {'local': e, 'remote': response.data},
          stackTrace: stack,
        );
      }
    } on DioException catch (e, stack) {
      throw _handleError(e, stack);
    }
  }

  Future<T> upload<T>(
    String path, {
    required List<String> filePaths,
    String fileKey = "files",
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    required T Function(dynamic json) parser,
    CancelToken? cancelToken,
    void Function(int sent, int total)? onProgress,
  }) async {
    if (filePaths.isEmpty) {
      throw ApiException("No files provided");
    }
    final files = await Future.wait(
      filePaths.map(
        (p) => MultipartFile.fromFile(p, filename: p.split('/').last),
      ),
    );

    final formData = FormData.fromMap({
      ...?data,
      fileKey: filePaths.length == 1 ? files.first : files,
    });

    final response = await request(
      path,
      parser: parser,
      headers: headers,
      method: HttpMethod.post,
      body: formData,
      cancelToken: cancelToken,
      onProgress: onProgress,
    );

    return response;
  }

  ApiException _handleError(DioException e, StackTrace stack) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException(
          "Connection timeout",
          type: ApiErrorType.timeout,
          stackTrace: stack,
        );

      case DioExceptionType.cancel:
        return ApiException(
          "Request cancelled",
          type: ApiErrorType.cancelled,
          stackTrace: stack,
        );

      case DioExceptionType.connectionError:
        return ApiException(
          "No internet connection",
          type: ApiErrorType.network,
          stackTrace: stack,
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;

        String message = "Server error";
        final data = e.response?.data;

        if (data is Map) {
          message = data["message"] ?? data["error"] ?? data["msg"] ?? message;
        } else if (data is String) {
          message = data;
        }

        return ApiException(
          message,
          statusCode: statusCode,
          type: statusCode == 401
              ? ApiErrorType.unauthorized
              : ApiErrorType.server,
          raw: e.response?.data,
          stackTrace: stack,
        );

      default:
        return ApiException(
          "Unexpected error",
          type: ApiErrorType.unknown,
          stackTrace: stack,
        );
    }
  }
}
