import 'package:sprint4_fix/features/home/domain/entity/appointment.dart';

class BookingState {
  final String? selectedDay;
  final String? selectedTime;
  final bool isConfirming;
  final List<Appointment> appointments; // Updated to use Appointment entity

  const BookingState({
    this.selectedDay,
    this.selectedTime,
    required this.isConfirming,
    required this.appointments,
  });

  factory BookingState.initial() => const BookingState(
        selectedDay: null,
        selectedTime: null,
        isConfirming: false,
        appointments: [], // Empty initially, fetched via use case
      );

  BookingState copyWith({
    String? selectedDay,
    String? selectedTime,
    bool? isConfirming,
    List<Appointment>? appointments,
  }) {
    return BookingState(
      selectedDay: selectedDay ?? this.selectedDay,
      selectedTime: selectedTime ?? this.selectedTime,
      isConfirming: isConfirming ?? this.isConfirming,
      appointments: appointments ?? this.appointments,
    );
  }
}
