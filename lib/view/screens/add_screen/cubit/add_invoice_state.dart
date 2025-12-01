import 'package:flutter/foundation.dart';

@immutable
class AddInvoiceState {
  final String selectedDate;
  final String selectedDeliveryDate;
  final bool showOverpay;

  AddInvoiceState({
    required this.selectedDate,
    required this.selectedDeliveryDate,
    required this.showOverpay,
  });

  AddInvoiceState copyWith({
    String? selectedDate,
    String? selectedDeliveryDate,
    bool? showOverpay,
  }) {
    return AddInvoiceState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDeliveryDate: selectedDeliveryDate ?? this.selectedDeliveryDate,
      showOverpay: showOverpay ?? this.showOverpay,
    );
  }
}
