import 'package:a/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../dio_consumer.dart';
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

      return Right(fields);
    } catch (e) {
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
}
