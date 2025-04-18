import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Melissa Peters');
  final TextEditingController _emailController =
      TextEditingController(text: 'melpeters@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '**********');
  final TextEditingController _dobController =
      TextEditingController(text: '23/05/1995');

  String selectedCountry = 'Nigeria';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _dobController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(1995, 5, 23),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _dobController.text =
                          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                    });
                  }
                },
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedCountry,
                items: ['Nigeria', 'Thailand', 'USA', 'UK']
                    .map((country) => DropdownMenuItem(
                          child: Text(country),
                          value: country,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Country/Region',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Changes Saved")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF20D2C4),
                  ),
                  child: Text("Save Change"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_seat),
            label: "Reservation",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Browse",
          ),
        ],
      ),
    );
  }
}
