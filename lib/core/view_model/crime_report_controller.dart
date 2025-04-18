import 'dart:convert';
import 'dart:io';
import 'package:a/core/view_model/main_controller.dart';
import 'package:a/models/created_by_model.dart';
import 'package:a/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constant/common_dialogs.dart';
import '../../constant/enums.dart';
import '../services/post_service.dart';

class CrimeReportController extends GetxController {
  final PostService postService = Get.find();
  var isReportSelected = true.obs;
  var isAnonymous = true.obs;

  var nameController = TextEditingController();
  var notesController = TextEditingController();
  var postNotesController = TextEditingController();
  var locationController = TextEditingController();
  var directionController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  var selectedCrime = RxnString();

  List<String> crimes = ['Theft', 'Assault', 'Vandalism', 'Burglary', 'Other'];

  void toggleReportPost(int index) {
    isReportSelected.value = index == 0;
  }

  void toggleAnonymous(int index) {
    isAnonymous.value = index == 0;
  }

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

  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  String get formattedDate =>
      DateFormat('EEE, dd MMM yyyy').format(selectedDate.value);

  String formattedTime(BuildContext context) =>
      selectedTime.value.format(context);

  final picker = ImagePicker();
  File? image;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  Future<String?> uploadImage() async {
    if (image == null) return null;

    var uri =
        Uri.parse('https://api.cloudinary.com/v1_1/dfuxtvzkj/image/upload');
    var request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = 'crime-app';
    request.fields['cloud_name'] = 'dfuxtvzkj';

    var pic = await http.MultipartFile.fromPath('file', image!.path);
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

  FutureState createPostState = FutureState.initial;

  Future<FutureState> createPost() async {
    createPostState = FutureState.loading;
    update();

    String? uploadedImageUrl;

    if (image != null) {
      uploadedImageUrl = await uploadImage();
    }

    final postModel = PostModel(
      caption: postNotesController.text,
      location: locationController.text,
      crimeTime: '$formattedDate At ${formattedTime(Get.context!)}',
      crimeType: selectedCrime.value!,
      createdBy: CreatedByModel(
        userID: 1,
        username: "Abdelrahman",
        profilePic:
        "https://firebasestorage.googleapis.com/v0/b/gog-web-13346.appspot.com/o/userPic%2F30.png?alt=media&token=3187c36e-7f11-421d-be27-8db64d843358",
      ),
      createdAt: selectedDate.value.toString(),
      postPic: uploadedImageUrl ??
          "https://firebasestorage.googleapis.com/v0/b/gog-web-13346.appspot.com/o/userPic%2F30.png?alt=media&token=3187c36e-7f11-421d-be27-8db64d843358",
    );

    final result = await postService.createPost(postModel: postModel);

    result.fold(
          (l) {
        createPostState = FutureState.failed;
        CommonDialogs.showErrorDialog(message: l.message);
      },
          (r) async {
        createPostState = FutureState.success;
        Get.find<MainController>().onItemTapped(0);
        CommonDialogs.showSuccessDialog(
          message: "Post Created Successfully",
        );
        await Get.find<MainController>().getInitialData();
      },
    );

    update();
    return createPostState;
  }

}
