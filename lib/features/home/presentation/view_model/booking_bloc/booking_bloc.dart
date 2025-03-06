import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/domain/entity/appointment.dart';
import 'package:sprint4_fix/features/home/domain/usecase/add_appointment.dart';
import 'package:sprint4_fix/features/home/domain/usecase/get_appointments.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/booking_bloc/booking_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/booking_bloc/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetAppointments getAppointments;
  final AddAppointment addAppointment;

  BookingBloc({
    required this.getAppointments,
    required this.addAppointment,
  }) : super(BookingState.initial()) {
    on<UpdateSelectedDay>(_onUpdateSelectedDay);
    on<UpdateSelectedTime>(_onUpdateSelectedTime);
    on<ShowConfirmation>(_onShowConfirmation);
    on<HideConfirmation>(_onHideConfirmation);
    on<AddAppointmentEvent>(
        _onAddAppointment); // Updated to AddAppointmentEvent
    on<FetchAppointments>(_onFetchAppointments);
  }

  void _onUpdateSelectedDay(
      UpdateSelectedDay event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedDay: event.day));
  }

  void _onUpdateSelectedTime(
      UpdateSelectedTime event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedTime: event.time));
  }

  void _onShowConfirmation(ShowConfirmation event, Emitter<BookingState> emit) {
    emit(state.copyWith(isConfirming: true));
  }

  void _onHideConfirmation(HideConfirmation event, Emitter<BookingState> emit) {
    emit(state.copyWith(isConfirming: false));
  }

  Future<void> _onAddAppointment(
      AddAppointmentEvent event, Emitter<BookingState> emit) async {
    final appointment = Appointment(
      station: event.station,
      day: state.selectedDay!,
      time: state.selectedTime!,
    );
    await addAppointment.call(appointment);
    final updatedAppointments = await getAppointments.call();
    emit(state.copyWith(
      appointments: updatedAppointments,
      selectedDay: null,
      selectedTime: null,
      isConfirming: false,
    ));
  }

  Future<void> _onFetchAppointments(
      FetchAppointments event, Emitter<BookingState> emit) async {
    final appointments = await getAppointments.call();
    emit(state.copyWith(appointments: appointments));
  }
}
