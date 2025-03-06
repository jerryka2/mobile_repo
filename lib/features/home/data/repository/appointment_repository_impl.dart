import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint4_fix/features/home/domain/entity/appointment.dart';
import 'package:sprint4_fix/features/home/domain/repository/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  static const String _appointmentsKey = 'appointments';

  @override
  Future<List<Appointment>> getAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? appointmentsJson = prefs.getString(_appointmentsKey);
    if (appointmentsJson == null) {
      return [
        // Initial demo data
        const Appointment(
            station: 'VoltCharge EV Hub', day: 'Monday', time: '10:00 AM'),
        const Appointment(
            station: 'Himalayan Charge Station',
            day: 'Wednesday',
            time: '2:00 PM'),
        const Appointment(
            station: 'City Power Station', day: 'Friday', time: '9:00 AM'),
        const Appointment(
            station: 'EcoCharge Point', day: 'Tuesday', time: '3:30 PM'),
        const Appointment(
            station: 'ThunderHub', day: 'Thursday', time: '11:00 AM'),
        const Appointment(
            station: 'Green Valley Station', day: 'Saturday', time: '1:00 PM'),
      ];
    }
    final List<dynamic> appointmentsList = jsonDecode(appointmentsJson);
    return appointmentsList
        .map((map) => Appointment.fromMap(map as Map<String, String>))
        .toList();
  }

  @override
  Future<void> addAppointment(Appointment appointment) async {
    final prefs = await SharedPreferences.getInstance();
    final appointments = await getAppointments();
    appointments.add(appointment);
    final appointmentsJson =
        jsonEncode(appointments.map((a) => a.toMap()).toList());
    await prefs.setString(_appointmentsKey, appointmentsJson);
  }
}
