import 'package:a/core/core/services/post_service.dart';
import 'package:a/models/post_model.dart';
import 'package:get/get.dart';

import '../../../constant/enums.dart';

class HomeController extends GetxController {
  final PostService postService = Get.find();

  FutureState getAllPostsState = FutureState.initial;

  List<PostModel> data = [];

  Future<FutureState> getAllPosts() async {
    try {
      data.clear();
      getAllPostsState = FutureState.loading;
      update();
      final result = await postService.getAllPosts();
      result.fold((l) {
        getAllPostsState = FutureState.failed;
        print(l.message);
      }, (r) {
        getAllPostsState = FutureState.success;
        data = r;
        print(data.toList());
      });
      update();
    }catch(e,s){
      print(e);
      print(s);
    }
    return getAllPostsState;
  }

  // FutureState createRegionState = FutureState.initial;
  //
  // Future<FutureState> createRegion({
  //   required int regionID,
  //   required String regionName,
  // }) async {
  //   createRegionState = FutureState.loading;
  //   update();
  //   final result = await regionServices.createNewRegion(regionName: regionName ,regionID: regionID);
  //   result.fold((l) {
  //     createRegionState = FutureState.failed;
  //     CommonDialogs.showErrorDialog(message: l.message);
  //   }, (r) {
  //     createRegionState = FutureState.success;
  //     CommonSnackbar.showSuccessSnackbar(message: "Region Created Successfully");
  //   });
  //   update();
  //   return createRegionState;
  // }

}