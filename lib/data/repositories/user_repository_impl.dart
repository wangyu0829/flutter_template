import 'package:clean_architecture_template/core/error/error_handler.dart';
import 'package:clean_architecture_template/core/error/exceptions.dart';
import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:clean_architecture_template/data/models/user_model.dart';
import 'package:clean_architecture_template/data/sources/user_service.dart';
import 'package:clean_architecture_template/domain/entities/user.dart';
import 'package:clean_architecture_template/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementation of [UserRepository] that uses [UserService] for API operations
class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  /// Creates a new [UserRepositoryImpl] with the given [userService]
  UserRepositoryImpl({required UserService userService}) : _userService = userService;

  @override
  Future<Either<Failure, User>> getUserById(String id) async {
    try {
      final user = await _userService.getUserById(id);
      return Right(user);
    } catch (e) {
      return ErrorHandler.handleException(e);
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await _userService.getCurrentUser();
      return Right(user);
    } catch (e) {
      return ErrorHandler.handleException(e);
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    try {
      if (user is! UserModel) {
        throw ValidationException.withDefaultCode(
          message: 'User must be a UserModel',
        );
      }
      
      final updatedUser = await _userService.updateUser(user);
      return Right(updatedUser);
    } catch (e) {
      return ErrorHandler.handleException(e);
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      final result = await _userService.signOut();
      return Right(result);
    } catch (e) {
      return ErrorHandler.handleException(e);
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final result = await _userService.isAuthenticated();
      return Right(result);
    } catch (e) {
      return ErrorHandler.handleException(e);
    }
  }
} 