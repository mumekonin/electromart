/// A simple wrapper around API results.
///
/// Why this class exists:
/// - Gives every successful call the same shape: data + optional message
/// - Makes repository code easier to read
/// - Keeps raw Dio [Response] objects out of the rest of the app
///
/// Note: Fake Store API returns plain JSON (not a `{ data, message }` envelope).
/// We wrap the JSON ourselves after a successful request.
class ApiResponse<T> {
  /// The parsed (or raw) payload from the API.
  final T? data;

  /// Optional human-readable message.
  final String? message;

  /// `true` when the request completed successfully.
  final bool success;

  const ApiResponse({
    this.data,
    this.message,
    required this.success,
  });

  /// Shortcut for a successful response.
  factory ApiResponse.success(T data, {String? message}) {
    return ApiResponse<T>(
      data: data,
      message: message,
      success: true,
    );
  }

  /// Shortcut for a failed response (when we choose not to throw).
  factory ApiResponse.failure(String message) {
    return ApiResponse<T>(
      data: null,
      message: message,
      success: false,
    );
  }
}
