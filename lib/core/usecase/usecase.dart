import 'package:dartz/dartz.dart';
import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:equatable/equatable.dart';

/// Base usecase interface for all usecases that don't need parameters
///
/// Type [T] is the return type of the usecase
abstract class UseCase<T> {
  /// Executes the usecase
  ///
  /// Returns a [Either] with a [Failure] on the left or the result of type [T] on the right
  Future<Either<Failure, T>> call();
}

/// Base usecase interface for all usecases that need parameters
///
/// Type [T] is the return type of the usecase
/// Type [Params] is the type of the parameters
abstract class UseCaseWithParams<T, Params> {
  /// Executes the usecase with the given [params]
  ///
  /// Returns a [Either] with a [Failure] on the left or the result of type [T] on the right
  Future<Either<Failure, T>> call(Params params);
}

/// Base usecase interface for all stream-based usecases that don't need parameters
///
/// Type [T] is the type of the items in the stream
abstract class StreamUseCase<T> {
  /// Executes the usecase
  ///
  /// Returns a [Stream] of type [T]
  Stream<T> call();
}

/// Base usecase interface for all stream-based usecases that need parameters
///
/// Type [T] is the type of the items in the stream
/// Type [Params] is the type of the parameters
abstract class StreamUseCaseWithParams<T, Params> {
  /// Executes the usecase with the given [params]
  ///
  /// Returns a [Stream] of type [T]
  Stream<T> call(Params params);
}

/// No parameters class for usecases that don't need parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
} 