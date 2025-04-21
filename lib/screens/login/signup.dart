import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Required for date formatting
import '/helpers/database_helper.dart'; // Assuming your DatabaseHelper is here

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isRegistering = false; // New state to track registration process

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  // State to hold the selected date
  DateTime? _selectedDate;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900), // Allow selecting dates far back
      lastDate: DateTime.now(), // Cannot select a future date
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Format the selected date and display it in the text field
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
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
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text("Sign up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Create an account to continue!"),
                  SizedBox(height: 24),
                  // Full Name Field
                  _buildTextField(
                    "Full Name",
                    controller: _fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter your full name";
                      return null;
                    },
                  ),
                  // Email Field
                  _buildTextField(
                    "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter your email";
                      // Basic email format validation
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  // Birth Date Field (uses the date picker)
                  Padding(
                     padding: const EdgeInsets.symmetric(vertical: 8),
                     child: TextFormField(
                       controller: _birthDateController,
                       readOnly: true, // Make field read-only
                       onTap: () => _selectDate(context), // Open date picker on tap
                       decoration: InputDecoration(
                         labelText: "Birth Date",
                         hintText: "DD/MM/YYYY",
                         prefixIcon: Icon(Icons.calendar_today), // Calendar icon
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                       ),
                       validator: (value) {
                         if (value == null || value.isEmpty) return "Please select your birth date";
                         return null;
                       },
                     ),
                  ),
                  // Phone Number Field
                  _buildTextField(
                    "Phone Number",
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icon(Icons.phone), // Changed icon for clarity
                    validator: (value) {
                       if (value == null || value.isEmpty) return "Please enter your phone number";
                       // Basic check, consider more robust validation if needed
                      if (value.length < 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                         return "Please enter a valid phone number";
                      }
                       return null;
                    },
                  ),
                  // Password Field (with toggle)
                  _buildPasswordField(),
                  SizedBox(height: 30),
                  // Register Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3CC4B4),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    // Disable button while registering
                    onPressed: _isRegistering ? null : () async {
                      if (_formKey.currentState!.validate()) {
                        // Start registration process
                        setState(() {
                          _isRegistering = true;
                        });

                        Map<String, dynamic> user = {
                          'fullName': _fullNameController.text,
                          'email': _emailController.text,
                          'birthDate': _birthDateController.text,
                          'phoneNumber': _phoneNumberController.text,
                          'password': _passwordController.text, // Consider hashing passwords before storing
                        };

                        try {
                          // Assuming insertUser is asynchronous and returns row ID or -1 on failure
                          int result = await DatabaseHelper().insertUser(user);

                          if (result != -1) {
                             // Success
                            Navigator.pushNamed(context, '/browse'); // Navigate on success
                          } else {
                            // Registration failed at database level
                            _showErrorDialog("Failed to register user. Database insertion failed.");
                          }
                        } catch (e) {
                           // Handle exceptions during database operation
                            _showErrorDialog("An error occurred during registration: $e");
                            print("Registration Error: $e"); // Log the error for debugging
                        } finally {
                          // Ensure _isRegistering is set to false whether successful or not
                          setState(() {
                            _isRegistering = false;
                          });
                        }
                      }
                    },
                    // Show loading indicator or button text
                    child: _isRegistering
                        ? CircularProgressIndicator(color: Colors.white) // Show indicator
                        : Text("REGISTER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  // Already have an account link
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login_2'), // Ensure this route is defined
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Color(0xFF3CC4B4), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for general text fields
  Widget _buildTextField(String label,
      {TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      String? hint,
      Widget? prefixIcon,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // Helper method specifically for the password field with toggle
  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        validator: (value) {
          if (value == null || value.isEmpty) return "Please enter a password";
          if (value.length < 6) return "Password must be at least 6 characters long";

          // Added checks for more complex passwords
          bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
          bool hasLowercase = value.contains(RegExp(r'[a-z]'));
          bool hasDigit = value.contains(RegExp(r'[0-9]'));
          // Optional: bool hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

          if (!hasUppercase || !hasLowercase || !hasDigit) {
            return "Password must contain uppercase, lowercase, and digits.";
          }
           // Optional: if (!hasSpecialChar) return "Password needs a special character.";

          return null; // Password is valid
        },
        decoration: InputDecoration(
          labelText: "Set Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
      ),
    );
  }
}