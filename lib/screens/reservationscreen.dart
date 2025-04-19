import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});
  
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<Map<String, String>> appointments = [];

  void _addAppointment(String title, String dateTime) {
    setState(() {
      appointments.add({'title': title, 'dateTime': dateTime});
    });
  }

  void _showAddAppointmentDialog() {
    String appointmentTitle = '';
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Appointment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Appointment Title'),
                    onChanged: (value) {
                      appointmentTitle = value;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final times = List.generate(
                        25,
                        (index) => TimeOfDay(hour: 8 + (index ~/ 2), minute: (index % 2) * 30),
                      );
                      TimeOfDay? pickedTime = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text('Select Time (08:00–20:00)'),
                            children: times.map((time) {
                              return SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, time),
                                child: Text(time.format(context)),
                              );
                            }).toList(),
                          );
                        },
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Text(selectedTime == null
                        ? 'Select Time'
                        : 'Time: ${selectedTime!.format(context)}'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (appointmentTitle.isNotEmpty &&
                        selectedDate != null &&
                        selectedTime != null) {
                      final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate!);
                      final timeStr = selectedTime!.format(context);
                      final dateTime = '$dateStr $timeStr';

                      // Check for conflicts
                      bool isConflict = appointments.any((appointment) =>
                          appointment['dateTime'] == dateTime);

                      if (isConflict) {
                        // Show a red error snackbar if the slot is already booked
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Conflict: This slot is already booked.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Add the appointment if no conflict
                        _addAppointment(appointmentTitle, dateTime);
                        Navigator.of(context).pop();
                      }
                    } else {
                      // Show a snackbar if any field is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill all fields.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Appointment'),
          content: Text('Are you sure you want to delete this appointment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  appointments.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/browse');
          },
        ),
        title: Text('Reservation'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: appointments.isEmpty
            ? Center(child: Text("No appointments yet."))
            : ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return _buildAppointmentTile(
                    appointments[index]['title']!,
                    appointments[index]['dateTime']!,
                    index,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAppointmentDialog,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF3cc4b4),
      ),
    );
  }

  Widget _buildAppointmentTile(String title, String dateTime, int index) {
    return ListTile(
      tileColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(Icons.calendar_today, color: Colors.teal),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(dateTime),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          _showDeleteConfirmationDialog(index);
        },
      ),
    );
  }
}