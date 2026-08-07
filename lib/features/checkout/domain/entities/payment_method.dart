/// Demo payment options shown on the Checkout screen.
///
/// Why this is not a real payment gateway:
/// - Fake Store API has no checkout / payment endpoint
/// - These options let beginners practice a Buy flow in the UI
enum PaymentMethod {
  /// Pay with a card (demo only — no real charge).
  card,

  /// Pay when the product is delivered.
  cashOnDelivery,

  /// Mobile wallet style option (demo only).
  mobileMoney,
}
