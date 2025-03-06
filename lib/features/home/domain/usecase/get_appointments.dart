import 'package:sprint4_fix/features/home/domain/entity/appointment.dart';
import 'package:sprint4_fix/features/home/domain/repository/appointment_repository.dart';

class GetAppointments {
  final AppointmentRepository repository;

  GetAppointments(this.repository);

  Future<List<Appointment>> call() async {
    return await repository.getAppointments();
  }
}
