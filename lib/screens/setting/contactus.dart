import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

              // Logo
              Center(
                child: Image.asset(
                  'assets/images/logo.png', // เปลี่ยน path ตามที่คุณตั้งไว้
                  height: 120,
                ),
              ),
              SizedBox(height: 24),

              // Email
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Name
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Content
              TextField(
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: UnderlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 24),

              // Checkbox
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  Text("I would like to receive the newsletter."),
                ],
              ),
              SizedBox(height: 16),

              // Social Icons (ใช้ icons จาก Flutter เอง)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 20), // Instagram
                    SizedBox(width: 16),
                    Icon(Icons.facebook, size: 20), // Facebook
                    SizedBox(width: 16),
                    Icon(Icons.video_library, size: 20), // YouTube
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3DD9C0), // ปุ่มสีเขียวฟ้า
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Reservation",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Browse",
          ),
        ],
        currentIndex: 0, // แก้ตาม logic
        onTap: (index) {
          // handle navigation
        },
      ),
    );
  }
}
