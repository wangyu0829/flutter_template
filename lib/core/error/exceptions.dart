/// Base class for all exceptions in the application
class AppException implements Exception {
  final String message;
  final String code;
  final dynamic details;

  AppException({
    required this.message,
    required this.code,
    this.details,
  });
}

/// Exception for server errors
class ServerException extends AppException {
  ServerException({
    required String message,
    required String code,
    dynamic details,
  }) : super(
          message: message,
          code: code,
          details: details,
        );

  factory ServerException.withDefaultCode({
    required String message,
    dynamic details,
  }) {
    return ServerException(
      message: message,
      code: 'SERVER_ERROR',
      details: details,
    );
  }
}

/// Exception for cache errors
class CacheException extends AppException {
  CacheException({
    required String message,
    required String code,
    dynamic details,
  }) : super(
          message: message,
          code: code,
          details: details,
        );

  factory CacheException.withDefaultCode({
    required String message,
    dynamic details,
  }) {
    return CacheException(
      message: message,
      code: 'CACHE_ERROR',
      details: details,
    );
  }
}

/// Exception for network errors
class NetworkException extends AppException {
  NetworkException({
    required String message,
    required String code,
    dynamic details,
  }) : super(
          message: message,
          code: code,
          details: details,
        );

  factory NetworkException.withDefaultCode({
    String message = 'Network connection error',
    dynamic details,
  }) {
    return NetworkException(
      message: message,
      code: 'NETWORK_ERROR',
      details: details,
    );
  }
}

/// Exception for authentication errors
class AuthException extends AppException {
  AuthException({
    required String message,
    required String code,
    dynamic details,
  }) : super(
          message: message,
          code: code,
          details: details,
        );

  factory AuthException.withDefaultCode({
    required String message,
    dynamic details,
  }) {
    return AuthException(
      message: message,
      code: 'AUTH_ERROR',
      details: details,
    );
  }
}

/// Exception for validation errors
class ValidationException extends AppException {
  ValidationException({
    required String message,
    required String code,
    dynamic details,
  }) : super(
          message: message,
          code: code,
          details: details,
        );

  factory ValidationException.withDefaultCode({
    required String message,
    dynamic details,
  }) {
    return ValidationException(
      message: message,
      code: 'VALIDATION_ERROR',
      details: details,
    );
  }
} 