import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract class for checking network connectivity
abstract class NetworkInfo {
  /// Checks if the device is connected to the Internet
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] that uses connectivity_plus package
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  /// Creates a new [NetworkInfoImpl] with the given [connectivity] instance
  NetworkInfoImpl({required this.connectivity});

  /// Checks if the device is connected to the Internet
  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
} 