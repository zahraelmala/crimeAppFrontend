import 'package:a/constant/common_dialogs.dart';
import 'package:a/view/screens/login_screen.dart';
import 'package:a/view/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordManagerPage extends StatefulWidget {
  const PasswordManagerPage({super.key});

  @override
  PasswordManagerPageState createState() => PasswordManagerPageState();
}

class PasswordManagerPageState extends State<PasswordManagerPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _togglePasswordVisibility(String field) {
    setState(() {
      if (field == 'current') {
        _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
      } else if (field == 'new') {
        _isNewPasswordVisible = !_isNewPasswordVisible;
      } else if (field == 'confirm') {
        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
      }
    });
  }

  Future<void> _changePassword() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        CommonDialogs.showErrorDialog(message: 'No user is logged in.');
        return;
      }
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPasswordController.text,
      );
      await user.reauthenticateWithCredential(credential);
      if (_newPasswordController.text != _confirmPasswordController.text) {
        CommonDialogs.showErrorDialog(
            message: 'New password and confirmation do not match.');
        return;
      }
      await user.updatePassword(_newPasswordController.text);
      CommonDialogs.showSuccessDialog(
          message: 'Password successfully changed!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      CommonDialogs.showErrorDialog(message: 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Password Manager',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              // Current Password Field
              const Text('Current Password'),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: !_isCurrentPasswordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isCurrentPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => _togglePasswordVisibility('current'),
                  ),
                  hintText: '****************',
                  border: const OutlineInputBorder(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    if (_auth.currentUser!.email!.isEmpty) {
                      CommonDialogs.showErrorDialog(
                          message: 'Enter your email first!');
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyEmailScreen(email: _auth.currentUser!.email!.trim())),
                    );
                  },
                  child: const Text(
                    'Forget your password?',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // New Password Field
              const Text('New Password'),
              TextFormField(
                controller: _newPasswordController,
                obscureText: !_isNewPasswordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => _togglePasswordVisibility('new'),
                  ),
                  hintText: '****************',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Confirm New Password Field
              const Text('Confirm New Password'),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => _togglePasswordVisibility('confirm'),
                  ),
                  hintText: '****************',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              // Change Password Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Change password',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
