import 'package:a/constant/common_dialogs.dart';
import 'package:a/models/post_comments_model.dart';
import 'package:a/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../constant/enums.dart';
import '../services/post_service.dart';

class HomeController extends GetxController {
  final PostService postService = Get.find();
  FutureState getAllPostsState = FutureState.initial;

  List<PostModel> data = [];
  RxList<PostModel> filteredData = <PostModel>[].obs;

  void filterPosts(String query) async {
    if (query.isEmpty) {
      filteredData.value = data;
    } else {
      filteredData.value = data
          .where(
            (post) => post.caption.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  Future<FutureState> getAllPosts() async {
    try {
      data.clear();
      getAllPostsState = FutureState.loading;
      update();

      final result = await postService.getAllPosts();

      result.fold(
        (failure) {
          getAllPostsState = FutureState.failed;
          if (kDebugMode) {
            print("Fetch failed: ${failure.message}");
          }
        },
        (posts) {
          print("Fetched ${posts.length} posts");
          data = posts;
          getAllPostsState = FutureState.success;
        },
      );

      update();
    } catch (e, s) {
      getAllPostsState = FutureState.failed;
      update();
      if (kDebugMode) {
        print("Exception: $e");
        print(s);
      }
    }

    return getAllPostsState;
  }

  Future<void> likePost(PostModel post) async {
    var result = await postService.likePost(postId: post.postId!);
    result.fold(
      (failure) {
        print("Failed to like post: $failure");
      },
      (success) {
        post.likes!.add(post.likes);
        update();
      },
    );
  }

  Future<void> unLikePost(PostModel post) async {
    var result = await postService.unLikePost(postId: post.postId!);
    result.fold(
      (failure) {
        print("Failed to unlike post: $failure");
      },
      (success) {
        post.likes!.remove(post.likes);
        update();
      },
    );
  }

  Future<void> updatePostLikes(int postId) async {
    var result = await postService.fetchPostById(postID: postId);
    result.fold(
      (failure) {
        print("Failed to fetch updated post: $failure");
      },
      (updatedPost) {
        int index = data.indexWhere((p) => p.postId == postId);
        if (index != -1) {
          data[index] = updatedPost;
          update();
        }
      },
    );
  }

  Future<void> addComment({
    required int postId,
    required String commentText,
  }) async {
    var result =
        await postService.addComment(postId: postId, commentText: commentText);
    result.fold(
      (failure) {
        if (kDebugMode) {
          print("Failed to Comment On Post: $failure");
        }
      },
      (success) {
        CommonDialogs.showSuccessDialog(
          message: "Comment Added Successfully",
        );
        update();
      },
    );
  }

  PostCommentsModel? postComments;
  FutureState getAllPostCommentsState = FutureState.initial;

  Future<PostCommentsModel> getAllPostComments({
    required int postID,
  }) async {
    try {
      final result = await postService.getPostComments(postID: postID);

      return result.fold(
        (failure) {
          if (kDebugMode) {
            print("Fetch failed: ${failure.message}");
          }
          throw Exception(failure.message);
        },
        (posts) {
          if (kDebugMode) {
            print(
              "Fetched ${posts.comments.length} comments for post ${posts.post.postId}");
          }
          return posts;
        },
      );
    } catch (e, s) {
      if (kDebugMode) {
        print("Exception: $e");
        print(s);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserDataByUid(String uid) async {
    try {
      final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        if (kDebugMode) {
          print("No user found with UID: $uid");
        }
        return null;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("Error fetching user data: $e");
        print(s);
      }
      return null;
    }
  }

}
