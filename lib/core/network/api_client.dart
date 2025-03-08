import 'dart:io';

import 'package:clean_architecture_template/core/error/exceptions.dart';
import 'package:clean_architecture_template/core/network/network_info.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// A wrapper around Dio for making API requests
class ApiClient {
  final Dio _dio;
  final Logger _logger;
  final NetworkInfo networkInfo;

  ApiClient({
    required Dio dio,
    required Logger logger,
    required this.networkInfo,
  })  : _dio = dio,
        _logger = logger;

  /// Makes a GET request to the specified [endpoint]
  ///
  /// [queryParameters] are optional key-value pairs for the query string
  /// [options] are optional Dio request options
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _executeRequest(
      () => _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Makes a POST request to the specified [endpoint]
  ///
  /// [data] is the request body
  /// [queryParameters] are optional key-value pairs for the query string
  /// [options] are optional Dio request options
  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _executeRequest(
      () => _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Makes a PUT request to the specified [endpoint]
  ///
  /// [data] is the request body
  /// [queryParameters] are optional key-value pairs for the query string
  /// [options] are optional Dio request options
  Future<dynamic> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _executeRequest(
      () => _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Makes a PATCH request to the specified [endpoint]
  ///
  /// [data] is the request body
  /// [queryParameters] are optional key-value pairs for the query string
  /// [options] are optional Dio request options
  Future<dynamic> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _executeRequest(
      () => _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Makes a DELETE request to the specified [endpoint]
  ///
  /// [data] is the optional request body
  /// [queryParameters] are optional key-value pairs for the query string
  /// [options] are optional Dio request options
  Future<dynamic> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _executeRequest(
      () => _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Executes a request with error handling
  ///
  /// [requestAction] is a function that returns a Future<Response>
  Future<dynamic> _executeRequest(
      Future<Response<dynamic>> Function() requestAction) async {
    try {
      // Check network connectivity
      if (!await networkInfo.isConnected) {
        throw NetworkException.withDefaultCode();
      }

      final response = await requestAction();
      _logger.d('API Response: ${response.statusCode} - ${response.data}');
      
      return response.data;
    } on DioException catch (e) {
      _logger.e('API Error: $e');
      
      _handleDioException(e);
    } on SocketException catch (e) {
      _logger.e('Socket Error: $e');
      
      throw NetworkException.withDefaultCode(
        message: 'Network connection error: ${e.message}',
      );
    } catch (e) {
      _logger.e('Unexpected Error: $e');
      
      throw ServerException.withDefaultCode(
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Handles Dio exceptions by throwing appropriate custom exceptions
  void _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException.withDefaultCode(
          message: 'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final responseData = exception.response?.data;
        
        if (statusCode == 401 || statusCode == 403) {
          throw AuthException(
            message: 'Authentication error: ${_extractErrorMessage(responseData) ?? 'Unauthorized'}',
            code: 'AUTH_ERROR_$statusCode',
          );
        } else if (statusCode == 404) {
          throw ServerException(
            message: 'Resource not found: ${_extractErrorMessage(responseData) ?? 'Not found'}',
            code: 'NOT_FOUND',
          );
        } else if (statusCode == 400) {
          throw ValidationException(
            message: 'Validation error: ${_extractErrorMessage(responseData) ?? 'Bad request'}',
            code: 'VALIDATION_ERROR',
          );
        } else if (statusCode != null && statusCode >= 500) {
          throw ServerException(
            message: 'Server error: ${_extractErrorMessage(responseData) ?? 'Internal server error'}',
            code: 'SERVER_ERROR_$statusCode',
          );
        } else {
          throw ServerException(
            message: 'HTTP error ${statusCode}: ${_extractErrorMessage(responseData) ?? 'Unknown error'}',
            code: 'HTTP_ERROR_${statusCode ?? "UNKNOWN"}',
          );
        }
      case DioExceptionType.cancel:
        throw ServerException(
          message: 'Request was cancelled',
          code: 'REQUEST_CANCELLED',
        );
      case DioExceptionType.unknown:
        if (exception.error is SocketException) {
          throw NetworkException.withDefaultCode(
            message: 'Network connection error. Please check your internet connection.',
          );
        }
        throw ServerException.withDefaultCode(
          message: 'Unknown error occurred: ${exception.message}',
        );
      default:
        throw ServerException.withDefaultCode(
          message: 'Unknown error occurred: ${exception.message}',
        );
    }
  }

  /// Extracts error message from response data
  String? _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return null;
    
    if (responseData is Map<String, dynamic>) {
      // Try common error message fields
      final possibleKeys = ['message', 'error', 'error_message', 'errorMessage'];
      
      for (final key in possibleKeys) {
        if (responseData.containsKey(key) && responseData[key] != null) {
          return responseData[key].toString();
        }
      }
      
      // Check nested error objects
      if (responseData.containsKey('error') && responseData['error'] is Map) {
        final errorObj = responseData['error'] as Map;
        if (errorObj.containsKey('message')) {
          return errorObj['message'].toString();
        }
      }
    }
    
    // If no structured error message was found, return the stringified data
    return responseData.toString();
  }
} 