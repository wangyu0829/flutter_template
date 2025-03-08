import 'dart:io';

import 'package:clean_architecture_template/core/error/exceptions.dart';
import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// A utility class for handling errors and exceptions consistently across the application
class ErrorHandler {
  /// Handles exceptions and converts them to failures
  /// Returns a [Left] with the appropriate [Failure]
  static Left<Failure, T> handleException<T>(dynamic exception) {
    if (exception is ServerException) {
      return Left(ServerFailure(
        message: exception.message,
        code: exception.code,
      ));
    } else if (exception is CacheException) {
      return Left(CacheFailure(
        message: exception.message,
        code: exception.code,
      ));
    } else if (exception is NetworkException) {
      return Left(NetworkFailure(
        message: exception.message, 
        code: exception.code,
      ));
    } else if (exception is AuthException) {
      return Left(AuthFailure(
        message: exception.message,
        code: exception.code,
      ));
    } else if (exception is ValidationException) {
      return Left(ValidationFailure(
        message: exception.message,
        code: exception.code,
      ));
    } else if (exception is DioException) {
      return Left(_handleDioException(exception));
    } else if (exception is SocketException) {
      return Left(NetworkFailure.withDefaultCode(
        message: 'Network connection error: ${exception.message}',
      ));
    } else {
      return Left(UnknownFailure(
        message: exception.toString(),
        code: 'UNKNOWN_ERROR',
      ));
    }
  }

  /// Handles Dio exceptions and converts them to appropriate failures
  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure.withDefaultCode(
          message: 'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final responseData = exception.response?.data;
        
        if (statusCode == 401 || statusCode == 403) {
          return AuthFailure(
            message: 'Authentication error: ${_extractErrorMessage(responseData) ?? 'Unauthorized'}',
            code: 'AUTH_ERROR_$statusCode',
          );
        } else if (statusCode == 404) {
          return ServerFailure(
            message: 'Resource not found: ${_extractErrorMessage(responseData) ?? 'Not found'}',
            code: 'NOT_FOUND',
          );
        } else if (statusCode == 400) {
          return ValidationFailure(
            message: 'Validation error: ${_extractErrorMessage(responseData) ?? 'Bad request'}',
            code: 'VALIDATION_ERROR',
          );
        } else if (statusCode != null && statusCode >= 500) {
          return ServerFailure(
            message: 'Server error: ${_extractErrorMessage(responseData) ?? 'Internal server error'}',
            code: 'SERVER_ERROR_$statusCode',
          );
        } else {
          return ServerFailure(
            message: 'HTTP error ${statusCode}: ${_extractErrorMessage(responseData) ?? 'Unknown error'}',
            code: 'HTTP_ERROR_${statusCode ?? "UNKNOWN"}',
          );
        }
      case DioExceptionType.cancel:
        return ServerFailure(
          message: 'Request was cancelled',
          code: 'REQUEST_CANCELLED',
        );
      case DioExceptionType.unknown:
        if (exception.error is SocketException) {
          return NetworkFailure.withDefaultCode(
            message: 'Network connection error. Please check your internet connection.',
          );
        }
        return UnknownFailure(
          message: 'Unknown error occurred: ${exception.message}',
          code: 'UNKNOWN_ERROR',
        );
      default:
        return UnknownFailure(
          message: 'Unknown error occurred: ${exception.message}',
          code: 'UNKNOWN_ERROR',
        );
    }
  }

  /// Extracts error message from response data
  static String? _extractErrorMessage(dynamic responseData) {
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