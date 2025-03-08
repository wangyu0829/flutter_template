import 'package:dartz/dartz.dart';
import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:clean_architecture_template/domain/entities/user.dart';

/// Repository interface for user operations
abstract class UserRepository {
  /// Gets a user by their ID
  ///
  /// Returns a [Either] with a [Failure] on the left or a [User] on the right
  Future<Either<Failure, User>> getUserById(String id);
  
  /// Gets the currently authenticated user
  ///
  /// Returns a [Either] with a [Failure] on the left or a [User] on the right
  Future<Either<Failure, User>> getCurrentUser();
  
  /// Updates the user information
  ///
  /// Returns a [Either] with a [Failure] on the left or a [User] on the right
  Future<Either<Failure, User>> updateUser(User user);
  
  /// Signs the user out
  ///
  /// Returns a [Either] with a [Failure] on the left or a [bool] on the right
  Future<Either<Failure, bool>> signOut();
  
  /// Checks if a user is authenticated
  ///
  /// Returns a [Either] with a [Failure] on the left or a [bool] on the right
  Future<Either<Failure, bool>> isAuthenticated();
} 