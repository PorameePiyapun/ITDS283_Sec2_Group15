import 'package:flutter/material.dart';
import '/helpers/database_helper.dart'; // Make sure this exists and has insertUser()

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  _buildTextField("Full Name", controller: _fullNameController, validator: (value) {
                    if (value == null || value.isEmpty) return "Enter full name";
                    return null;
                  }),
                  _buildTextField("Email", controller: _emailController, keyboardType: TextInputType.emailAddress, validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) return "Enter valid email";
                    return null;
                  }),
                  _buildTextField("Birth Date", controller: _birthDateController, hint: "DD/MM/YYYY", validator: (value) {
                    if (value == null || value.isEmpty) return "Enter birth date";
                    return null;
                  }),
                  _buildTextField("Phone Number", controller: _phoneNumberController, keyboardType: TextInputType.phone, prefixIcon: Icon(Icons.flag), validator: (value) {
                    if (value == null || value.length < 10) return "Enter valid phone number";
                    return null;
                  }),
                  _buildPasswordField(),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3CC4B4),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Prepare user data for insertion
                        Map<String, dynamic> user = {
                          'fullName': _fullNameController.text,
                          'email': _emailController.text,
                          'birthDate': _birthDateController.text,
                          'phoneNumber': _phoneNumberController.text,
                          'password': _passwordController.text,
                        };
                        // Try inserting user and handle success/failure
                        int result = await DatabaseHelper().insertUser(user);
                        if (result != -1) {
                          // Navigate after successful registration
                          Navigator.pushNamed(context, '/browse');
                        } else {
                          _showErrorDialog("Failed to register user. Please try again.");
                        }
                      }
                    },
                    child: Text("REGISTER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login_2'),
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

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        validator: (value) {
          if (value == null || value.length < 6) return "Password must be at least 6 characters";
          return null;
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
}
