import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  int _timerSeconds = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _canResend = false; // ✅ Ensure "Resend Code" is disabled at the start
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _timerSeconds = 60;
      _canResend = false; // ✅ Disable "Resend Code" when timer starts
    });

    _timer?.cancel(); // ✅ Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        timer.cancel();
        setState(() => _canResend = true); // ✅ Enable "Resend Code" after timer ends
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/crimecatcher.png', height: 50), // Crime Catcher Logo
            const SizedBox(height: 20),
            Image.asset('assets/images/verification.png', height: 200), // Verification Illustration
            const SizedBox(height: 20),

            const Text(
              'Verification Code',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 5),
            const Text(
              'Please enter Code sent to',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const Text(
              '01011222224',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 20),

            // OTP Input
            Pinput(
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 50,
                height: 50,
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Timer & Resend Code
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _timerSeconds > 0 ? '00:${_timerSeconds.toString().padLeft(2, '0')}' : '',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _canResend ? _startTimer : null,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: _canResend ? Colors.red : Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Send', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
