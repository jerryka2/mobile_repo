abstract class BookingEvent {
  const BookingEvent();
}

class UpdateSelectedDay extends BookingEvent {
  final String day;
  const UpdateSelectedDay(this.day);
}

class UpdateSelectedTime extends BookingEvent {
  final String time;
  const UpdateSelectedTime(this.time);
}

class ShowConfirmation extends BookingEvent {
  const ShowConfirmation();
}

class HideConfirmation extends BookingEvent {
  const HideConfirmation();
}

class AddAppointmentEvent extends BookingEvent {
  // Renamed from AddAppointment
  final String station;
  const AddAppointmentEvent(this.station);
}

class FetchAppointments extends BookingEvent {
  const FetchAppointments();
}
