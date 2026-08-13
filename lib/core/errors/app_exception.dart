/// Base class untuk semua exception dalam app.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Error dari network / HTTP request.
final class NetworkException extends AppException {
  const NetworkException(super.message, {this.statusCode});

  final int? statusCode;
}

/// Error saat parsing / serialisasi data.
final class ParseException extends AppException {
  const ParseException(super.message);
}

/// Error karena resource tidak ditemukan.
final class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

/// Error tidak diketahui / unexpected.
final class UnknownException extends AppException {
  const UnknownException([String message = 'An unexpected error occurred.'])
      : super(message);
}
