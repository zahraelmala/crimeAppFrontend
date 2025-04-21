import 'package:a/view/screens/resetPassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/verify_code_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController otpController = TextEditingController();
  final VerifyCodeService _verifyService = Get.find();

  bool isResendDisabled = false;
  int timerSeconds = 60;

  void startResendTimer() {
    setState(() {
      isResendDisabled = true;
      timerSeconds = 60;
    });

    // Count down every second
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (timerSeconds > 1) {
        setState(() => timerSeconds--);
        return true;
      } else {
        setState(() {
          isResendDisabled = false;
          timerSeconds = 60;
        });
        return false;
      }
    });
  }

  void verifyCode() async {
    final enteredCode = otpController.text.trim();

    if (enteredCode.length != 4) {
      _showSnackBar("Please enter a valid 4-digit code");
      return;
    }

    final result = await _verifyService.checkVerifyCode(
      email: widget.email,
      code: enteredCode,
    );

    result.fold(
          (failure) => _showSnackBar(failure.message),
          (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ResetPasswordScreen(email: widget.email)),
        );
      },
    );
  }

  void resendCode() async {
    if (isResendDisabled) return;

    final result = await _verifyService.sendVerifyCode(email: widget.email);

    result.fold(
          (failure) => _showSnackBar(failure.message),
          (success) {
        _showSnackBar("Verification code sent to ${widget.email}");
        startResendTimer();
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - kToolbarHeight),
          child: IntrinsicHeight(
            child: Padding(
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
                    widget.email,
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
