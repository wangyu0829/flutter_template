import 'package:clean_architecture_template/core/network/api_client.dart';
import 'package:clean_architecture_template/data/models/user_model.dart';

/// Interface for user-related API operations
abstract class UserService {
  /// Gets a user by their ID
  Future<UserModel> getUserById(String id);
  
  /// Gets the currently authenticated user
  Future<UserModel> getCurrentUser();
  
  /// Updates a user's information
  Future<UserModel> updateUser(UserModel user);
  
  /// Signs the user out
  Future<bool> signOut();
  
  /// Checks if a user is authenticated
  Future<bool> isAuthenticated();
}

/// Implementation of [UserService] that uses the API client
class UserServiceImpl implements UserService {
  final ApiClient _apiClient;
  
  /// Creates a new [UserServiceImpl] with the given [apiClient]
  UserServiceImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  
  @override
  Future<UserModel> getUserById(String id) async {
    final response = await _apiClient.get('/users/$id');
    return UserModel.fromJson(response);
  }
  
  @override
  Future<UserModel> getCurrentUser() async {
    final response = await _apiClient.get('/users/me');
    return UserModel.fromJson(response);
  }
  
  @override
  Future<UserModel> updateUser(UserModel user) async {
    final response = await _apiClient.put(
      '/users/${user.id}',
      data: user.toJson(),
    );
    return UserModel.fromJson(response);
  }
  
  @override
  Future<bool> signOut() async {
    final response = await _apiClient.post('/auth/signout');
    return response['success'] == true;
  }
  
  @override
  Future<bool> isAuthenticated() async {
    try {
      final response = await _apiClient.get('/auth/status');
      return response['authenticated'] == true;
    } catch (e) {
      return false;
    }
  }
} 