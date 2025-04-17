import 'package:a/view/screens/resetPassword.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  final String email; // Pass email dynamically

  const VerifyEmail({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final TextEditingController otpController = TextEditingController();
  bool isResendDisabled = false;
  int timerSeconds = 60;

  void startResendTimer() {
    setState(() {
      isResendDisabled = true;
      timerSeconds = 60;
    });

    Future.delayed(Duration(seconds: 60), () {
      setState(() {
        isResendDisabled = false;
      });
    });
  }

  void verifyCode() {
    String enteredCode = otpController.text.trim();

    if (enteredCode.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid 4-digit code")),
      );
      return;
    }

    // Here, you should check the entered code with the actual verification code
    // Example: If using Firebase, you may need a backend API to handle email verification codes.

    // If successful, navigate to Reset Password screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: "user@example.com"),),
    );
  }

  void resendCode() {
    if (isResendDisabled) return;

    // Implement your resend code logic here (Firebase or custom API)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Verification code sent to ${widget.email}")),
    );

    startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the 4-digit code',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.email, // Show the actual email
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: '----',
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isResendDisabled ? "$timerSeconds sec" : "Resend Code",
                  style: const TextStyle(color: Colors.red),
                ),
                TextButton(
                  onPressed: isResendDisabled ? null : resendCode,
                  child: const Text("Resend Code", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 250),
          ],
        ),
      ),
    );
  }
}

