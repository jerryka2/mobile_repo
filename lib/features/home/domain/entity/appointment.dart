class Appointment {
  final String station;
  final String day;
  final String time;

  const Appointment({
    required this.station,
    required this.day,
    required this.time,
  });

  Map<String, String> toMap() {
    return {
      'station': station,
      'day': day,
      'time': time,
    };
  }

  factory Appointment.fromMap(Map<String, String> map) {
    return Appointment(
      station: map['station']!,
      day: map['day']!,
      time: map['time']!,
    );
  }
}
