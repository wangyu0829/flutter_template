part of 'user_bloc.dart';

/// Base class for all user states
abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

/// Initial state of the user bloc
class UserInitial extends UserState {}

/// State when a user is being loaded
class UserLoading extends UserState {}

/// State when a user has been loaded successfully
class UserLoaded extends UserState {
  /// The loaded user
  final User user;

  /// Creates a new [UserLoaded] state with the given [user]
  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

/// State when an error occurs while loading a user
class UserError extends UserState {
  /// The error message
  final String message;

  /// Creates a new [UserError] state with the given [message]
  const UserError({required this.message});

  @override
  List<Object> get props => [message];
} 