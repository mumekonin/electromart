import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/payment_method.dart';

/// Holds the payment method the user picked on Checkout.
///
/// Why this class exists:
/// - One provider = one responsibility (selected payment only)
/// - Does NOT talk to an API (checkout is a local demo)
class SelectedPaymentMethodNotifier extends Notifier<PaymentMethod> {
  @override
  PaymentMethod build() => PaymentMethod.cashOnDelivery;

  /// Updates the radio selection.
  void select(PaymentMethod method) {
    state = method;
  }
}

/// Provider for the currently selected demo payment method.
final selectedPaymentMethodProvider =
    NotifierProvider<SelectedPaymentMethodNotifier, PaymentMethod>(
  SelectedPaymentMethodNotifier.new,
);
