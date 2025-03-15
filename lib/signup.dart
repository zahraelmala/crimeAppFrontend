import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart'; // Redirect after verification
import 'verification_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Sign-Up function with Firebase Authentication
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Navigate to Verification Screen (Optional)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerificationPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  // Validators
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value) ? null : 'Enter a valid email';
  }

  String? _validateID(String? value) {
    if (value == null || value.isEmpty) return 'ID number is required';
    return RegExp(r'^\d{14}$').hasMatch(value) ? null : 'ID must be exactly 14 digits';
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    return RegExp(r'^(010|011|012|015)\d{8}$').hasMatch(value) ? null : 'Enter a valid Egyptian phone number';
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return value.length >= 6 ? null : 'Password must be at least 6 characters';
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm Password is required';
    return value == _passwordController.text ? null : 'Passwords do not match';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Join as Guest Button
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text("Join as guest", style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ),

                // Logo
                Image.asset('assets/images/crimecatcher.png', width: 150),

                const SizedBox(height: 10),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
                ),

                const SizedBox(height: 20),
                _buildTextField(Icons.person, "User Name", _usernameController, "User name is required"),
                _buildTextField(Icons.email, "Email", _emailController, null, validator: _validateEmail),
                _buildTextField(Icons.credit_card, "ID", _idController, null, validator: _validateID, keyboardType: TextInputType.number),
                _buildTextField(Icons.phone, "Mobile Number", _mobileController, null, validator: _validatePhone, keyboardType: TextInputType.phone),
                _buildPasswordField("Password", _passwordController, _isPasswordVisible, _validatePassword, () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                }),
                _buildPasswordField("Confirm Password", _confirmPasswordController, _isConfirmPasswordVisible, _validateConfirmPassword, () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                }),

                const SizedBox(height: 20),

                // Sign-Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _signUp,
                    child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),

                const SizedBox(height: 10),

                // Login Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: const Text("Log in", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Common TextField Widget
  Widget _buildTextField(IconData icon, String hintText, TextEditingController controller, String? requiredMessage,
      {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ?? (value) => (value == null || value.isEmpty) ? requiredMessage : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.red),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // Password Field with Validation & Visibility Toggle
  Widget _buildPasswordField(String hintText, TextEditingController controller, bool isVisible, String? Function(String?) validator, VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: Colors.red),
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
            onPressed: toggleVisibility,
          ),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}


