import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:clean_architecture_template/core/usecase/usecase.dart';
import 'package:clean_architecture_template/domain/entities/user.dart';
import 'package:clean_architecture_template/domain/repositories/user_repository.dart';

/// Use case to get a user by their ID
class GetUserByIdUseCase implements UseCaseWithParams<User, GetUserByIdParams> {
  final UserRepository repository;

  /// Creates a new [GetUserByIdUseCase] with the given [repository]
  GetUserByIdUseCase({required this.repository});

  /// Executes the use case with the given [params]
  ///
  /// Returns a [Either] with a [Failure] on the left or a [User] on the right
  @override
  Future<Either<Failure, User>> call(GetUserByIdParams params) async {
    return await repository.getUserById(params.userId);
  }
}

/// Parameters for [GetUserByIdUseCase]
class GetUserByIdParams extends Equatable {
  /// The ID of the user to get
  final String userId;

  /// Creates a new [GetUserByIdParams] with the given [userId]
  const GetUserByIdParams({required this.userId});

  @override
  List<Object> get props => [userId];
} 