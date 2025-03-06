import 'package:sprint4_fix/features/home/domain/entity/appointment.dart';

abstract class AppointmentRepository {
  Future<List<Appointment>> getAppointments();
  Future<void> addAppointment(Appointment appointment);
}
