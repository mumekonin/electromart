/// Domain entity for a product category.
///
/// Why this class exists:
/// - Fake Store returns plain strings like "electronics"
/// - Wrapping them in an entity keeps UI code clearer
/// - [displayName] formats the label for chips (no hardcoding)
class Category {
  const Category({required this.name});

  /// Exact category value from the API (used in requests).
  final String name;

  /// Nice label for the UI (example: "men's clothing" → "Men's Clothing").
  String get displayName {
    if (name.isEmpty) return name;

    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).join(' ');
  }

  @override
  bool operator ==(Object other) {
    return other is Category && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
