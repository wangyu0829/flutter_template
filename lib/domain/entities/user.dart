import 'package:equatable/equatable.dart';

/// User entity representing a user in the system
class User extends Equatable {
  /// The unique identifier of the user
  final String id;
  
  /// The username of the user
  final String username;
  
  /// The email address of the user
  final String email;
  
  /// The avatar URL of the user
  final String? avatarUrl;
  
  /// Flag indicating if the user is active
  final bool isActive;
  
  /// The creation date of the user account
  final DateTime createdAt;
  
  /// Creates a new [User] instance
  const User({
    required this.id,
    required this.username,
    required this.email,
    this.avatarUrl,
    required this.isActive,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [id, username, email, avatarUrl, isActive, createdAt];
} 