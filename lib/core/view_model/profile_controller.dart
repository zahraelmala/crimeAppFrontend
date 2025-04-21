import 'dart:convert';

import 'package:a/constant/date_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant/common_dialogs.dart';
import '../../constant/enums.dart';
import '../../models/post_model.dart';
import '../services/post_service.dart';

class ProfileController extends GetxController {
  final PostService postService = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var myPosts = <PostModel>[].obs;

  var getAllPostsState = FutureState.initial.obs;

  Future<FutureState> getAllPosts() async {
    try {
      myPosts.clear();
      getAllPostsState.value = FutureState.loading;
      update();
      final result = await postService.getAllPosts();
      result.fold((l) {
        getAllPostsState.value = FutureState.failed;
        if (kDebugMode) {
          print(l.message);
        }
      }, (r) async {
        getAllPostsState.value = FutureState.success;
        update();
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          final userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
          if (userDoc.exists) {
            final userData = userDoc.data() ?? {};
            final currentUsername = userData['username'];
            print(currentUsername);
            myPosts.value = r
                .where((post) => post.username == currentUsername)
                .toList();
          }
        }
      });
      update();
    } catch (e, s) {
      getAllPostsState.value = FutureState.failed;
      update();
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
    return getAllPostsState.value;
  }

  var userName = ''.obs;
  var userEmail = ''.obs;
  var profileImageUrl = ''.obs;
  var birthDate = ''.obs;
  var createdAt = ''.obs;
  var firstName = ''.obs;
  var gender = ''.obs;
  var lastName = ''.obs;
  var mobile = ''.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  var selectedGender = RxnString();
  List<String> genders = [
    'Male',
    'Female',
  ];
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

  FutureState getUserDate = FutureState.initial;

  Future<void> fetchUserData() async {
    getUserDate = FutureState.loading;
    update();
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        userEmail.value = currentUser.email ?? '';

        final userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (userDoc.exists) {
          final data = userDoc.data() ?? {};

          userName.value = data['username'] ?? '';
          profileImageUrl.value = data['profilePic'] ?? '';

          // Handle birthDate safely
          final birthRaw = data['birthDate'];
          if (birthRaw is Timestamp) {
            selectedDate.value = birthRaw.toDate();
            birthDate.value = DateFormatter.parsedAndFormattedDate(birthRaw.toDate().toString());
          } else if (birthRaw is String) {
            selectedDate.value = DateTime.tryParse(birthRaw) ?? DateTime.now();
            birthDate.value = DateFormatter.parsedAndFormattedDate(selectedDate.value.toString());
          }

          // Handle createdAt safely
          final createdRaw = data['createdAt'];
          if (createdRaw is Timestamp) {
            createdAt.value = DateFormatter.parsedAndFormattedDate(createdRaw.toDate().toString());
          } else if (createdRaw is String) {
            createdAt.value = DateFormatter.parsedAndFormattedDate(createdRaw);
          }

          firstName.value = data['firstName'] ?? '';
          gender.value = data['gender'] ?? '';
          lastName.value = data['lastName'] ?? '';
          mobile.value = data['mobile'] ?? '';
          selectedGender.value = gender.value;

          firstNameController.text = firstName.value;
          lastNameController.text = lastName.value;
          usernameController.text = userName.value;
          emailController.text = userEmail.value;
          mobileController.text = mobile.value;
        }
        getUserDate = FutureState.success;
        update();
      }
    } catch (e) {
      getUserDate = FutureState.failed;
      update();
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  final picker = ImagePicker();
  var image = Rxn<XFile?>();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = pickedFile;
    }
  }

  Future<String?> uploadImage() async {
    if (image.value == null) return null;

    var uri =
    Uri.parse('https://api.cloudinary.com/v1_1/dfuxtvzkj/image/upload');
    var request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = 'crime-app';
    request.fields['cloud_name'] = 'dfuxtvzkj';

    var pic = await http.MultipartFile.fromPath('file', image.value!.path);
    request.files.add(pic);

    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var data = jsonDecode(res.body);
      CommonDialogs.showSuccessDialog(message: 'Upload Success!');
      return data['url'];
    } else {
      CommonDialogs.showErrorDialog(message: 'Upload Failed');
      return null;
    }
  }

  Future<void> updateUserField(String fieldName, dynamic newValue) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser.uid).update({
          fieldName: newValue,
        });

        if (fieldName == 'username') {
          userName.value = newValue;
        } else if (fieldName == 'profilePic') {
          profileImageUrl.value = newValue;
        }else if (fieldName == 'birthDate') {
          birthDate.value = newValue;
        }else if (fieldName == 'createdAt') {
          createdAt.value = newValue;
        }else if (fieldName == 'firstName') {
          firstName.value = newValue;
        }else if (fieldName == 'gender') {
          gender.value = newValue;
        }else if (fieldName == 'lastName') {
          lastName.value = newValue;
        }else if (fieldName == 'mobile') {
          mobile.value = newValue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }

  FutureState updateProfileState = FutureState.initial;

  Future<void> updateProfile() async {
    updateProfileState = FutureState.loading;
    update();
    try {
      final updates = <String, dynamic>{};

      if (firstNameController.text != firstName.value) {
        updates['firstName'] = firstNameController.text;
      }
      if (lastNameController.text != lastName.value) {
        updates['lastName'] = lastNameController.text;
      }
      if (usernameController.text != userName.value) {
        updates['username'] = usernameController.text;
      }
      if (selectedDate.value.toString() != birthDate.value) {
        updates['birthDate'] = selectedDate.value.toString();
      }
      if (selectedGender.value != gender.value) {
        updates['gender'] = selectedGender.value;
      }
      if (mobileController.text != mobile.value) {
        updates['mobile'] = mobileController.text;
      }

      if (updates.isNotEmpty) {
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          await _firestore.collection('users').doc(currentUser.uid).update(updates);
          updates.forEach((key, value) {
            updateUserField(key, value);
          });
        }
      }

      updateProfileState = FutureState.success;
      CommonDialogs.showSuccessDialog(message: 'Update Success!');
      Get.back();
    } catch (e) {
      updateProfileState = FutureState.failed;
      CommonDialogs.showErrorDialog(message: 'Update Failed!');
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }


}
