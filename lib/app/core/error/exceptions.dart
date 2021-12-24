/// for Remote Layer
class ServerException implements Exception {}

/// for Local Layer
class CacheException implements Exception {
  final String? message;

  CacheException({this.message});
}
