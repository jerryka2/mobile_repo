import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/booking_bloc/booking_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/booking_bloc/booking_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/booking_bloc/booking_state.dart';

class BookingPage extends StatelessWidget {
  final Map<String, dynamic> station;

  const BookingPage({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        title: Text(
          "Book at ${station['name']}",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade700, Colors.green.shade500],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, "Select Your Day"),
                  const SizedBox(height: 10),
                  _buildDropdown(
                    context,
                    value: state.selectedDay,
                    hint: "Choose a day",
                    items: [
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday'
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<BookingBloc>()
                            .add(UpdateSelectedDay(value));
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  _buildSectionTitle(context, "Select Your Time"),
                  const SizedBox(height: 10),
                  _buildDropdown(
                    context,
                    value: state.selectedTime,
                    hint: "Choose a time",
                    items: [
                      '9:00 AM',
                      '10:00 AM',
                      '11:00 AM',
                      '1:00 PM',
                      '2:00 PM',
                      '3:30 PM'
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<BookingBloc>()
                            .add(UpdateSelectedTime(value));
                      }
                    },
                  ),
                  const Spacer(),
                  Center(
                    child: _buildConfirmButton(context, state),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18,
          ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(
          hint,
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
        isExpanded: true,
        underline: const SizedBox(), // Remove default underline
        icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context, BookingState state) {
    final isEnabled = state.selectedDay != null && state.selectedTime != null;
    return GestureDetector(
      onTap: isEnabled ? () => _showConfirmationDialog(context) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEnabled
                ? [Colors.green.shade600, Colors.green.shade400]
                : [Colors.grey.shade400, Colors.grey.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(isEnabled ? 0.4 : 0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          "Confirm Booking",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final bloc = context.read<BookingBloc>();
    if (bloc.state.selectedDay != null && bloc.state.selectedTime != null) {
      bloc.add(const ShowConfirmation());
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          final stationName = station['name']?.toString() ?? "Unnamed Station";
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text(
              "Confirm Booking",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Station: $stationName",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text("Day: ${bloc.state.selectedDay}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text("Time: ${bloc.state.selectedTime}",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  bloc.add(const HideConfirmation());
                },
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  bloc.add(AddAppointmentEvent(stationName));
                  Navigator.pop(dialogContext); // Close dialog
                  Navigator.pop(context); // Back to AppointmentPage
                },
                child: const Text("Confirm",
                    style: TextStyle(color: Colors.green)),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please select both a day and a time!"),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }
}
