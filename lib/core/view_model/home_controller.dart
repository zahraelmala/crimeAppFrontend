import 'package:a/models/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../constant/enums.dart';
import '../services/post_service.dart';

class HomeController extends GetxController {
  final PostService postService = Get.find();

  FutureState getAllPostsState = FutureState.initial;

  List<PostModel> data = [];
  RxList<PostModel> filteredData = <PostModel>[].obs;

  void filterPosts(String query) async{
    if (query.isEmpty) {
      filteredData.value = data;
    } else {
      filteredData.value = data
          .where((post) => post.caption.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<FutureState> getAllPosts() async {
    try {
      data.clear();
      getAllPostsState = FutureState.loading;
      update();
      final result = await postService.getAllPosts();
      result.fold((l) {
        getAllPostsState = FutureState.failed;
        if (kDebugMode) {
          print(l.message);
        }
      }, (r) {
        getAllPostsState = FutureState.success;
        data = r;
      });
      update();
    }catch(e,s){
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
    return getAllPostsState;
  }

}