import 'package:a/constant/enums.dart';
import 'package:a/core/view_model/auth_controller.dart';
import 'package:a/view/widgets/sign_up_widgets/sign_up_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/home_screen.dart';
import '../../screens/login_screen.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SignUpForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: const Text("Join as guest",
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            ),
          ),

          // Logo
          Image.asset('assets/images/crimecatcher.png', width: 150),

          const SizedBox(height: 10),
          const Text(
            "Create Account",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
          ),

          const SizedBox(height: 20),
          SignUpTextField(
              icon: Icons.person,
              hintText: "First Name",
              controller: controller.firstNameController,
              requiredMessage: "First name is required",
              keyboardType: TextInputType.text),
          SignUpTextField(
              icon: Icons.person,
              hintText: "Last Name",
              controller: controller.lastNameController,
              requiredMessage: "Last name is required",
              keyboardType: TextInputType.text),
          SignUpTextField(
            icon: Icons.person,
            hintText: "Username",
            controller: controller.usernameController,
            requiredMessage: "User name is required",
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => controller.selectDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today, color: Colors.red),
                hintText: "Date",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(controller.formattedDate),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.report, color: Colors.red),
              hintText: "Gender",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            value: controller.selectedGender.value,
            onChanged: (value) => controller.selectedGender.value = value,
            items: controller.genders.map(
              (crime) {
                return DropdownMenuItem<String>(
                  value: crime,
                  child: Text(crime),
                );
              },
            ).toList(),
          ),
          SignUpTextField(
            icon: Icons.email,
            hintText: "Email",
            controller: controller.emailController,
            requiredMessage: null,
            validator: controller.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SignUpTextField(
            icon: Icons.phone,
            hintText: "Mobile Number",
            controller: controller.mobileController,
            requiredMessage: null,
            validator: controller.validatePhone,
            keyboardType: TextInputType.phone,
          ),
          _buildPasswordField(
            "Password",
            controller.passwordController,
            controller.isPasswordVisible,
            controller.validatePassword,
            () {
              controller.isPasswordVisible = !controller.isPasswordVisible;
              controller.update();
            },
          ),
          _buildPasswordField(
            "Confirm Password",
            controller.confirmPasswordController,
            controller.isConfirmPasswordVisible,
            controller.validateConfirmPassword,
            () {
              controller.isConfirmPasswordVisible =
                  !controller.isConfirmPasswordVisible;
              controller.update();
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await controller.signUp();
                }
              },
              child: controller.signUpState == FutureState.loading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
      String hintText,
      TextEditingController controller,
      bool isVisible,
      String? Function(String?) validator,
      VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: Colors.red),
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey),
            onPressed: toggleVisibility,
          ),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
