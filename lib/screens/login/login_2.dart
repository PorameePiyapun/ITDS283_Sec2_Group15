import 'package:flutter/material.dart';
import '/helpers/database_helper.dart'; // Import the DatabaseHelper class
import 'dart:developer'; // Import for logging

class Login2Screen extends StatefulWidget {
  @override
  _Login2ScreenState createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  final _formKey = GlobalKey<FormState>(); // Add Form key for validation
  bool _obscurePassword = true; // State for password visibility toggle
  bool _isLoggingIn = false; // State to track login process

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    // Check if the widget is still mounted before showing a dialog
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Login Error'), // More specific title
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Sign in method
  Future<void> _signIn() async {
    log('--- _signIn method started ---'); // Use log for debugging

    // Validate the form fields
    if (!_formKey.currentState!.validate()) {
      log('Form validation failed.');
      log('--- _signIn method ended (validation failed) ---');
      return; // Stop if validation fails
    }

    // Use .trim() for email to remove potential leading/trailing spaces
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    log('Attempting login with Email: "$email"');

    // Set logging in state to true and rebuild to show loading indicator
    setState(() {
      _isLoggingIn = true;
    });

    try {
      final dbHelper = DatabaseHelper();
      log('DatabaseHelper instance created.');

      // Get the user by email from the database
      // Assuming getUserByEmail returns a Map<String, dynamic>? or null
      final user = await dbHelper.getUserByEmail(email);

      // Print the user data retrieved from the database (be cautious with sensitive data in logs)
      log('User from DB for "$email": $user');

      // Check if a user was found and if the password matches
      // Note: In a real app, you should securely hash and compare passwords,
      // not store and compare them in plain text.
      if (user != null && user['password'] == password) {
        // Successfully signed in
        log('Password matches. Login successful!');
        // Check if the widget is still mounted before navigating
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home'); // Navigate to home page or main screen
          log('Navigated to /home');
        }
      } else {
        // Login failed (user not found or password mismatch)
        log('Login failed: User not found or password incorrect.');
        // Check if the widget is still mounted before showing a dialog
        if (mounted) {
          _showErrorDialog('Invalid email or password');
          log('Error dialog shown (login failed).');
        }
      }
    } catch (e) {
      // Catch any errors during the async operation (e.g., database errors)
      log('*** An unexpected error occurred during _signIn: $e ***', error: e); // Log the error
      // Optionally show an error dialog for unexpected errors
      // Check if the widget is still mounted
      if (mounted) {
        _showErrorDialog('An unexpected error occurred. Please try again.');
      }
    } finally {
      // Ensure _isLoggingIn is set to false whether successful or not
      if (mounted) {
         setState(() {
           _isLoggingIn = false;
         });
         log('_isLoggingIn set to false.');
      }
      log('--- _signIn method ended ---');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Center( // Centering the content vertically
          child: SingleChildScrollView( // Added SingleChildScrollView
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20), // Adjusted padding
            child: Form( // Wrapped content in Form
              key: _formKey, // Assign the form key
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center column items vertically
                crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch items horizontally
                children: [
                  // Assuming you have an asset 'assets/logo.png'
                  Image.asset(
                    'assets/logo.png',
                    height: 150, // Slightly reduced height
                  ),
                  SizedBox(height: 40), // Adjusted spacing
                  Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 8),
                   Text(
                    'Log in to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Email Input Field
                  TextFormField( // Changed to TextFormField
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
                      prefixIcon: Icon(Icons.email_outlined), // Outline version icon
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      // Basic email format validation
                       if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
                         return "Please enter a valid email address";
                       }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  // Password Input Field
                  TextFormField( // Changed to TextFormField
                    controller: _passwordController,
                    obscureText: _obscurePassword, // Use state for obscurity
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
                      prefixIcon: Icon(Icons.lock_outline), // Outline version icon
                      suffixIcon: IconButton( // Password visibility toggle icon
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey, // Icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword; // Toggle obscurity state
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  // Log In Button
                  ElevatedButton(
                    onPressed: _isLoggingIn ? null : _signIn, // Disable button while logging in
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Color(0xFF3CC4B4), // Example accent color
                       padding: EdgeInsets.symmetric(vertical: 15),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8), // Rounded corners
                       ),
                    ),
                    child: _isLoggingIn
                        ? SizedBox( // Show loading indicator
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text( // Show button text
                            'Log In',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                  SizedBox(height: 20), // Space before Sign Up link
                  // Sign Up link
                  TextButton(
                    onPressed: () {
                      // Navigate to your SignUp screen
                      Navigator.pushNamed(context, '/signup'); // Ensure this route is defined
                    },
                    child: Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}