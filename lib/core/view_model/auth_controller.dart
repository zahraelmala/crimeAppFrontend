import 'package:a/constant/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/common_dialogs.dart';
import '../../view/screens/main_screen.dart';

class AuthController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var selectedGender = RxnString();
  List<String> genders = [
    'Male',
    'Female',
  ];
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  var selectedDate = DateTime.now().obs;

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  String get formattedDate => DateFormat('EEE, dd MMM yyyy').format(selectedDate.value);

  // Validators
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value) ? null : 'Enter a valid email';
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    return RegExp(r'^(010|011|012|015)\d{8}$').hasMatch(value) ? null : 'Enter a valid Egyptian phone number';
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return value.length >= 6 ? null : 'Password must be at least 6 characters';
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm Password is required';
    return value == passwordController.text ? null : 'Passwords do not match';
  }

  Future<void> createUserProfile({
    required String firstName,
    required String lastName,
    required String username,
    required String birthDate,
    required String gender,
    required String mobile,
    required String profilePic,
  }) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      try{
      await userRef.set({
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': user.email,
        'birthDate': birthDate,
        'gender': gender,
        'mobile': mobile,
        'profilePic': profilePic,
        'createdAt': FieldValue.serverTimestamp(),
      });
      } catch (e) {
        if (kDebugMode) print("🔥 Firestore write error: $e");
      }
    }
  }

  FutureState signUpState = FutureState.initial;

  Future<void> signUp() async {
    try{
      signUpState = FutureState.loading;
      update();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await createUserProfile(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        username: usernameController.text,
        birthDate: selectedDate.value.toString(),
        gender: selectedGender.value!,
        mobile: mobileController.text,
        profilePic: "https://example.com/pic.jpg"
      );
      signUpState = FutureState.success;
      Navigator.pushReplacement(
        Get.context!,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
      CommonDialogs.showSuccessDialog(message: 'Sign Up Success!');
      firstNameController.clear();
      lastNameController.clear();
      usernameController.clear();
      emailController.clear();
      mobileController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      selectedGender.value = null;
      selectedDate.value = DateTime.now();
      update();
    }catch(e,s){
      if (kDebugMode) {
        print(e);
        print(s);
      }
      signUpState = FutureState.failed;
      update();
    }
  }
}
