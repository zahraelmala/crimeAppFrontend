import 'package:a/core/services/firebase_service.dart';
import 'package:a/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../models/post_comments_model.dart';
import '../api/dio_consumer.dart';
import '../errors/error_handler.dart';
import '../errors/failure.dart';

/// Service class responsible for managing account fields through API calls.
///
/// It relies on the [DioConsumer] to handle all requests for each function.
class PostService extends GetxService {
  /// Instance of [DioConsumer] for making API requests.
  final DioConsumer dioConsumer = Get.find();

  /// Retrieves all account fields from the server.
  ///
  /// Returns a [List] of [PostModel] or an [Failure] if the request fails.
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    try {
      final res = await dioConsumer.get(
        endpoint: '/posts/',
      );
      final fields =
          (res.data as List).map((field) => PostModel.fromMap(field)).toList();
      print(fields);
      return Right(fields);
    } catch (e) {
      if (kDebugMode) print("Dio error: $e");
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, PostModel>> fetchPostById(
      {required int postID}) async {
    try {
      final res = await dioConsumer.get(
        endpoint: '/posts/$postID/',
      );
      final post = PostModel.fromMap(res.data);
      return Right(post);
    } catch (e) {
      if (kDebugMode) print("Dio error: $e");
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  /// Creates a new post on the server.
  ///
  /// Returns [true] if the creation is successful or a [Failure] if the request fails.
  Future<Either<Failure, bool>> createPost({
    required PostModel postModel,
  }) async {
    try {
      await dioConsumer.post(
        endpoint: '/posts/',
        data: postModel.toJson(),
      );

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<dynamic, bool>> likePost({
    required int postId,
  }) async {
    try {
      String? idToken =
          await Get.find<FirebaseAuthService>().getCurrentUserToken();
      if (idToken != null) {
        Get.find<DioConsumer>().updateToken(idToken);
        await dioConsumer.post(
          endpoint: '/posts/$postId/like/',
        );
      } else {
        return Left("No Logged In User Found");
      }

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<dynamic, bool>> unLikePost({
    required int postId,
  }) async {
    try {
      String? idToken =
          await Get.find<FirebaseAuthService>().getCurrentUserToken();
      if (idToken != null) {
        Get.find<DioConsumer>().updateToken(idToken);
        await dioConsumer.post(
          endpoint: '/posts/$postId/unlike/',
        );
      } else {
        return Left("No Logged In User Found");
      }

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  /// Updates an existing Post on the server.
  ///
  /// Returns [true] if the update is successful or a [Failure] if the request fails.
  Future<Either<Failure, bool>> updatePost({
    required PostModel postModel,
  }) async {
    try {
      await dioConsumer.put(
        endpoint: '/posts/${postModel.postId}/',
        data: postModel.toJson(),
      );

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  /// Deletes an existing Post field from the server.
  ///
  /// Returns [true] if the deletion is successful or a [Failure] if the request fails.
  Future<Either<Failure, bool>> deletePost({
    required int postId,
  }) async {
    try {
      await dioConsumer.delete(
        endpoint: '/posts/$postId/',
      );

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<dynamic, bool>> addComment({
    required int postId,
    required String commentText,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? idToken =
          await Get.find<FirebaseAuthService>().getCurrentUserToken();
      if (idToken != null) {
        Get.find<DioConsumer>().updateToken(idToken);
        if (user != null) {
          await dioConsumer.post(
            endpoint: '/posts/$postId/comment/',
            data: {
              "post": postId,
              "firebase_uid": user.uid,
              "text": commentText
            },
          );
        } else {
          return Left("No Logged In User Found (UUID)");
        }
      } else {
        return Left("No Logged In User Found (TOKEN)");
      }

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, PostCommentsModel>> getPostComments(
      {required int postID}) async {
    try {
      final res = await dioConsumer.get(
        endpoint: '/posts/$postID/comments-detail/',
      );
      final post = PostCommentsModel.fromMap(res.data);
      return Right(post);
    } catch (e) {
      if (kDebugMode) print("Dio error: $e");
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
