part of 'user_bloc.dart';

/// Base class for all user events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

/// Event to get a user by their ID
class GetUserById extends UserEvent {
  /// The ID of the user to get
  final String userId;

  /// Creates a new [GetUserById] event with the given [userId]
  const GetUserById({required this.userId});

  @override
  List<Object> get props => [userId];
} 