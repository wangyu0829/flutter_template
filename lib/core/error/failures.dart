import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final String code;

  const Failure({required this.message, required this.code});

  @override
  List<Object> get props => [message, code];
}

/// Failure related to server errors
class ServerFailure extends Failure {
  const ServerFailure({required String message, required String code}) 
      : super(message: message, code: code);
  
  factory ServerFailure.withDefaultCode({required String message}) {
    return ServerFailure(message: message, code: 'SERVER_ERROR');
  }
}

/// Failure related to cache errors
class CacheFailure extends Failure {
  const CacheFailure({required String message, required String code}) 
      : super(message: message, code: code);
  
  factory CacheFailure.withDefaultCode({required String message}) {
    return CacheFailure(message: message, code: 'CACHE_ERROR');
  }
}

/// Failure related to network connectivity
class NetworkFailure extends Failure {
  const NetworkFailure({required String message, required String code}) 
      : super(message: message, code: code);
  
  factory NetworkFailure.withDefaultCode({String message = 'Network connection error'}) {
    return NetworkFailure(message: message, code: 'NETWORK_ERROR');
  }
}

/// Failure related to authentication
class AuthFailure extends Failure {
  const AuthFailure({required String message, required String code}) 
      : super(message: message, code: code);
  
  factory AuthFailure.withDefaultCode({required String message}) {
    return AuthFailure(message: message, code: 'AUTH_ERROR');
  }
}

/// Failure with unknown reasons
class UnknownFailure extends Failure {
  const UnknownFailure({required String message, required String code}) 
      : super(message: message, code: code);
  
  factory UnknownFailure.withDefaultMessage({String code = 'UNKNOWN_ERROR'}) {
    return UnknownFailure(message: 'An unknown error occurred', code: code);
  }
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({required String message, required String code}) 
      : super(message: message, code: code);
  
  factory ValidationFailure.withDefaultCode({required String message}) {
    return ValidationFailure(message: message, code: 'VALIDATION_ERROR');
  }
} 