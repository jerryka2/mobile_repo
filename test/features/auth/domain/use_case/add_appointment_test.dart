import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/home/domain/entity/appointment.dart';
import 'package:sprint4_fix/features/home/domain/repository/appointment_repository.dart';
import 'package:sprint4_fix/features/home/domain/usecase/add_appointment.dart';

// Mock Repository
class MockAppointmentRepository extends Mock implements AppointmentRepository {}

void main() {
  late MockAppointmentRepository mockAppointmentRepository;
  late AddAppointment addAppointment;

  setUp(() {
    mockAppointmentRepository = MockAppointmentRepository();
    addAppointment = AddAppointment(mockAppointmentRepository);
  });

  final testAppointment = Appointment(
    station: 'EV Station 1', // Corrected required fields
    day: 'Monday',
    time: '14:30',
    // dateTime: DateTime(2025, 3, 10, 14, 30),
    // description: 'Doctor Appointment',
  );

  test('calls addAppointment on repository with correct appointment', () async {
    when(() => mockAppointmentRepository.addAppointment(testAppointment))
        .thenAnswer((_) async {});

    await addAppointment.call(testAppointment);

    verify(() => mockAppointmentRepository.addAppointment(testAppointment))
        .called(1);
  });
}
