import 'package:clean_architecture_template/domain/entities/user.dart';

/// Data model for a user, extends the [User] entity
class UserModel extends User {
  /// Creates a new [UserModel] instance
  const UserModel({
    required String id,
    required String username,
    required String email,
    String? avatarUrl,
    required bool isActive,
    required DateTime createdAt,
  }) : super(
          id: id,
          username: username,
          email: email,
          avatarUrl: avatarUrl,
          isActive: isActive,
          createdAt: createdAt,
        );

  /// Creates a [UserModel] from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Converts this [UserModel] to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar_url': avatarUrl,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Creates a copy of this [UserModel] with the given fields replaced
  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 