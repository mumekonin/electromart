import 'network_exception.dart';

/// Maps any thrown error into a short user-facing sentence.
///
/// Why this helper exists:
/// - Avoids copy-pasting the same if/else in every provider
/// - UI never needs to know about [NetworkException] details
String mapErrorMessage(
  Object error, {
  String fallback = 'Something went wrong. Please try again.',
}) {
  if (error is NetworkException) {
    return error.message;
  }
  return fallback;
}
