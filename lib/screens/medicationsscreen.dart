import 'package:flutter/material.dart';

class MedicationsScreen extends StatefulWidget {
  @override
  _MedicationsScreenState createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  List<Map<String, String>> medications = [];

  void _addMedication(String name, String dateTime) {
    setState(() {
      medications.add({'name': name, 'dateTime': dateTime});
    });
  }

  void _showAddMedicationDialog() {
    String medicationName = '';
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Medication'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Medication Name'),
                    onChanged: (value) {
                      medicationName = value;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
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
                        : 'Date: ${selectedDate!.toLocal()}'.split(' ')[0]),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
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
                    if (medicationName.isNotEmpty &&
                        selectedDate != null &&
                        selectedTime != null) {
                      final dateTime = '${selectedDate!.toLocal()}'.split(' ')[0] +
                          ' ${selectedTime!.format(context)}';
                      _addMedication(medicationName, dateTime);
                      Navigator.of(context).pop(); // Close the dialog after adding
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
          title: Text('Delete Medication'),
          content: Text('Are you sure you want to delete this medication?'),
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
                  medications.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog after deleting
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
        title: Text('Medications'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: medications.length,
          itemBuilder: (context, index) {
            return _buildMedicationTile(
              medications[index]['name']!,
              medications[index]['dateTime']!,
              index,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMedicationDialog,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF3cc4b4),
      ),
    );
  }

  Widget _buildMedicationTile(String name, String dateTime, int index) {
    return ListTile(
      tileColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(Icons.local_pharmacy, color: Colors.lightBlue),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
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