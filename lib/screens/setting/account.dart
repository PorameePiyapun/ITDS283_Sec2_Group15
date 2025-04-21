import 'package:flutter/material.dart';
import '/helpers/database_helper.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // State variable to track password visibility

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedUser = {
        'fullName': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phoneNumber': '1234567890', // Example phone number
      };

      try {
        await DatabaseHelper().updateUser(_emailController.text, updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Changes Saved")),
        );
      } catch (e) {
        print('Error updating user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save changes")),
        );
      }
    }
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _deleteAccount();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    try {
      await DatabaseHelper().deleteUserByEmail(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account Deleted")),
      );
      Navigator.pushReplacementNamed(context, '/'); // Navigate to login screen
    } catch (e) {
      print('Error deleting account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete account")),
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Account Information"), // Updated headline
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: _confirmDeleteAccount,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Save Changes Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveChanges,
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
    );
  }
}