import 'package:sprint4_fix/features/home/domain/entity/appointment.dart';
import 'package:sprint4_fix/features/home/domain/repository/appointment_repository.dart';

class AddAppointment {
  final AppointmentRepository repository;

  AddAppointment(this.repository);

  Future<void> call(Appointment appointment) async {
    await repository.addAppointment(appointment);
  }
}
