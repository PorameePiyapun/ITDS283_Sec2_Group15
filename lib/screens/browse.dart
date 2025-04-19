import 'package:flutter/material.dart';
import 'package:help_you_to_mu_health/screens/bmi_screen.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int _selectedIndex = 2; // 2 = Browse

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/reservation');
    }
    // index == 2 is current page (Browse), so no need to do anything
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "Health Categories",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _buildCategoryTile(Icons.local_fire_department, "Activity", Colors.deepOrange),
            const SizedBox(height: 12),
            _buildCategoryTile(
              Icons.accessibility_new,
              "Body Measurements",
              Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BMIScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildCategoryTile(Icons.favorite, "Heart", Colors.red),
            medication(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(IconData icon, String title, Color iconColor, {VoidCallback? onTap}) {
    return ListTile(
      tileColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget medication() {
    return Column(
      children: [
        const SizedBox(height: 12),
        _buildCategoryTile(
          Icons.local_pharmacy,
          "Medications",
          Colors.lightBlue,
          onTap: () {
            Navigator.pushNamed(context, '/medication');
          },
        ),
      ],
    );
  }
}