import 'package:flutter/material.dart';

class TargetHeartRateCalculatorScreen extends StatefulWidget {
  @override
  _TargetHeartRateCalculatorScreenState createState() =>
      _TargetHeartRateCalculatorScreenState();
}

class _TargetHeartRateCalculatorScreenState
    extends State<TargetHeartRateCalculatorScreen> {
  final _ageController = TextEditingController();
  String _result = '';
  Map<String, int> _thrValues = {};

  void _calculateHeartRate() {
    final age = int.tryParse(_ageController.text);
    if (age != null) {
      final mhr = 220 - age; // Maximum Heart Rate (MHR)
      _thrValues = {
        'Maximum VO2 Max Zone': (mhr * 0.9).toInt(),
        'Hard Anaerobic Zone': (mhr * 0.8).toInt(),
        'Moderate Aerobic Zone': (mhr * 0.7).toInt(),
        'Light Fat Burn Zone': (mhr * 0.6).toInt(),
        'Very Light Warm Up Zone': (mhr * 0.5).toInt(),
      };

      setState(() {
        _result = 'MHR = $mhr bpm\n\n';
      });
    } else {
      setState(() {
        _result = 'Please enter a valid age.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Target Heart Rate Calculator'),
        backgroundColor: Color(0xFF3cc4b4),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Age:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateHeartRate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3cc4b4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Calculate'),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _result,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Table(
                    border: TableBorder.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    children: _thrValues.entries.map((entry) {
                      return _buildTableRow(entry.key, entry.value);
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String zone, int bpm) {
    Color backgroundColor;
    switch (zone) {
      case 'Maximum VO2 Max Zone':
        backgroundColor = Color(0xFFFFCCCC);
        break;
      case 'Hard Anaerobic Zone':
        backgroundColor = Color(0xFFFFFFCC);
        break;
      case 'Moderate Aerobic Zone':
        backgroundColor = Color(0xFFCCFFCC);
        break;
      case 'Light Fat Burn Zone':
        backgroundColor = Color(0xFFCCEFFF);
        break;
      case 'Very Light Warm Up Zone':
        backgroundColor = Color(0xFFEEEEEE);
        break;
      default:
        backgroundColor = Colors.white;
    }

    return TableRow(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            zone,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$bpm bpm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}