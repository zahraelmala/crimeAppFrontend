import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/view_model/profile_controller.dart';
import 'package:a/constant/custom_button.dart';
import 'package:a/view/widgets/sign_up_widgets/sign_up_text_field.dart';
import '../../constant/enums.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Obx(() => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Your Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.profileImageUrl.value.isNotEmpty
                          ? NetworkImage(controller.profileImageUrl.value)
                          : const AssetImage("assets/images/profile_icon.png")
                      as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.red,
                        child: InkWell(
                            onTap: controller.pickImage,
                            child: Icon(Icons.edit, color: Colors.white, size: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              if(controller.image.value != null) ...[
                const SizedBox(height: 10),
                CustomButton(
                  onTap: () async{
                    String? uploadedImageUrl;
                    if (controller.image.value != null) {
                      uploadedImageUrl = await controller.uploadImage();
                    }
                    await controller.updateUserField("profilePic", uploadedImageUrl);
                    controller.image.value = null;
                  },
                  label: "Change Photo",
                  buttonColor: Colors.red,
                  textColor: Colors.white,
                ),
              ],
              const SizedBox(height: 10),
              Text(
                controller.userName.value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              Text(
                controller.userEmail.value,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SignUpTextField(
                icon: Icons.person,
                hintText: "First Name",
                controller: controller.firstNameController,
                requiredMessage: "First name is required",
                keyboardType: TextInputType.text,
              ),
              SignUpTextField(
                icon: Icons.person,
                hintText: "Last Name",
                controller: controller.lastNameController,
                requiredMessage: "Last name is required",
                keyboardType: TextInputType.text,
              ),
              SignUpTextField(
                icon: Icons.person,
                hintText: "Username",
                controller: controller.usernameController,
                requiredMessage: "User name is required",
                keyboardType: TextInputType.text,
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
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async{
                    await controller.updateProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: controller.updateProfileState == FutureState.loading
                    ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                    : Text("Update profile", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}