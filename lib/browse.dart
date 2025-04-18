import 'package:flutter/material.dart';
 // Ensure ReservationScreen is imported
 
 class BrowseScreen extends StatefulWidget {
   @override
   _BrowseScreenState createState() => _BrowseScreenState();
 }
 
 class _BrowseScreenState extends State<BrowseScreen> {
   int _currentIndex = 2; // Default index for Browse tab
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
         items: const [
           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
           BottomNavigationBarItem(icon: Icon(Icons.event_note), label: "Reservation"),
           BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
         ],
         currentIndex: _currentIndex,
         onTap: (index) {
           setState(() {
             _currentIndex = index;
           });
 
           if (index == 1) {
             // Navigate to ReservationScreen when tapping on Reservation
             Navigator.pushNamed(context, '/reservation');
           } else if (index == 0) {
             Navigator.pushNamed(context, '/'); // Navigate to Home if needed
           }
         },
       ),
       body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.all(20),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: const [
                   Expanded(
                     child: Text("Browse", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                   ),
                   CircleAvatar(
                     backgroundImage: AssetImage("assets/avatar.png"),
                     radius: 18,
                   ),
                 ],
               ),
               const SizedBox(height: 16),
               TextField(
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search),
                   hintText: "Search",
                   filled: true,
                   fillColor: Colors.grey[200],
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                 ),
               ),
               const SizedBox(height: 24),
               const Text("Health Categories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
               const SizedBox(height: 16),
               ...[
                 _buildCategoryTile(Icons.local_fire_department, "Activity", Colors.deepOrange),
                 _buildCategoryTile(Icons.accessibility_new, "Body Measurements", Colors.purple),
                 _buildCategoryTile(Icons.favorite, "Heart", Colors.red),
                 _buildCategoryTile(Icons.local_pharmacy, "Medications", Colors.lightBlue),
               ]
             ],
           ),
         ),
       ),
     );
   }
 
   Widget _buildCategoryTile(IconData icon, String label, Color color) {
     return Column(
       children: [
         ListTile(
           contentPadding: EdgeInsets.zero,
           leading: Icon(icon, color: color),
           title: Text(label),
           onTap: () {},
         ),
         Divider(height: 0),
       ],
     );
   }
 }
