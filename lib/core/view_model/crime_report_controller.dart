import 'dart:convert';
import 'dart:io';

import 'package:a/core/view_model/main_controller.dart';
import 'package:a/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

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

  List<String> crimes = [
    'Theft',
    'Assault',
    'Vandalism',
    'Burglary',
    'Other',
  ];

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
  var isMediaLoading = false.obs;
  File? mediaFile;
  VideoPlayerController? videoController;

  Future<void> pickMedia() async {
    final mediaType = await showDialog<MediaType>(
      context: Get.context!,
      builder: (context) => SimpleDialog(
        title: Text("Select Media Type"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, MediaType.image),
            child: Text("Image"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, MediaType.video),
            child: Text("Video"),
          ),
        ],
      ),
    );

    if (mediaType == null) return;

    isMediaLoading.value = true;

    // Pick image or video based on selection
    final pickedFile = mediaType == MediaType.image
        ? await picker.pickImage(source: ImageSource.gallery)
        : await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (mediaType == MediaType.image) {
        mediaFile = File(pickedFile.path);
        update();
      } else if (mediaType == MediaType.video) {
        mediaFile = File(pickedFile.path);
        videoController = VideoPlayerController.file(mediaFile!)
          ..initialize().then((_) => update());
        update();
      }
    }
    isMediaLoading.value = false;
  }

  Future<String?> uploadMedia() async {
    if (mediaFile == null) return null;

    var uri =
    Uri.parse('https://api.cloudinary.com/v1_1/dfuxtvzkj/upload');
    var request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = 'crime-app';
    request.fields['cloud_name'] = 'dfuxtvzkj';

    var file = await http.MultipartFile.fromPath('file', mediaFile!.path);
    request.files.add(file);

    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var data = jsonDecode(res.body);
      CommonDialogs.showSuccessDialog(message: 'Upload Success!');
      return data['secure_url'];
    } else {
      CommonDialogs.showErrorDialog(message: 'Upload Failed');
      return null;
    }
  }

  var createPostState = FutureState.initial.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? userName;
  String? profileImageUrl;

  Future<bool> checkFields() async{
    bool hasError = false;
    if(isMediaLoading.value == true) {
      CommonDialogs.showErrorDialog(message: "Media is loading");
      hasError = true;
    }
    if (selectedCrime.value == null) {
      CommonDialogs.showErrorDialog(message: "Please select a crime");
      hasError = true;
    }
    if (locationController.text.isEmpty) {
      CommonDialogs.showErrorDialog(message: "Please enter a location");
      hasError = true;
    }
    if (postNotesController.text.isEmpty) {
      CommonDialogs.showErrorDialog(message: "Please enter a post notes");
      hasError = true;
    }
    if (selectedDate.value == DateTime.now()) {
      CommonDialogs.showErrorDialog(message: "Please select a date");
      hasError = true;
    }
    if (selectedTime.value == TimeOfDay.now()) {
      CommonDialogs.showErrorDialog(message: "Please select a time");
      hasError = true;
    }
    if (mediaFile == null) {
      CommonDialogs.showErrorDialog(message: "Please select a media");
      hasError = true;
    }
    return !hasError;
  }

  Future<FutureState> createPost() async {
    createPostState.value = FutureState.loading;
    update();

    String? uploadedMediaUrl;

    if (mediaFile != null) {
      uploadedMediaUrl = await uploadMedia();
    }

    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userDoc =
      await _firestore.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        final data = userDoc.data() ?? {};

        userName = data['username'] ?? '';
        profileImageUrl = data['profilePic'] ?? '';
      }
    }

    print(userName);
    print(profileImageUrl);

    final postModel = PostModel(
      caption: postNotesController.text,
      location: locationController.text,
      crimeTime: '$formattedDate At ${formattedTime(Get.context!)}',
      crimeType: selectedCrime.value!,
      username: userName!,
      profilePic: profileImageUrl!,
      postPic: uploadedMediaUrl ??
          "https://firebasestorage.googleapis.com/v0/b/gog-web-13346.appspot.com/o/userPic%2F30.png?alt=media&token=3187c36e-7f11-421d-be27-8db64d843358",
    );

    final result = await postService.createPost(postModel: postModel);

    result.fold(
          (l) {
            createPostState.value = FutureState.failed;
        CommonDialogs.showErrorDialog(message: l.message);
      },
          (r) async {
            createPostState.value = FutureState.success;
        Get.find<MainController>().onItemTapped(0);
        CommonDialogs.showSuccessDialog(
          message: "Post Created Successfully",
        );
        await Get.find<MainController>().getInitialData();
        locationController.clear();
        postNotesController.clear();
        selectedDate.value = DateTime.now();
        selectedTime.value = TimeOfDay.now();
        selectedCrime.value = null;
        mediaFile = null;
        videoController?.dispose();
        videoController = null;
      },
    );
    update();
    return createPostState.value;
  }
}

enum MediaType { image, video }
