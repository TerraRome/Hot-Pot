import 'package:hot_pot/core/errors/app_exception.dart';

/// Base class untuk failure di domain layer.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {this.statusCode});

  final int? statusCode;
}

final class ParseFailure extends Failure {
  const ParseFailure(super.message);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Something went wrong.'])
      : super(message);
}

/// Convert [AppException] ke [Failure].
Failure exceptionToFailure(AppException e) => switch (e) {
      NetworkException(:final message, :final statusCode) =>
        NetworkFailure(message, statusCode: statusCode),
      ParseException(:final message) => ParseFailure(message),
      NotFoundException(:final message) => NotFoundFailure(message),
      UnknownException(:final message) => UnknownFailure(message),
    };
