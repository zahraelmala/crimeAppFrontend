import 'package:a/constant/date_formatter.dart';
import 'package:a/core/view_model/home_controller.dart';
import 'package:a/models/post_comments_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/post_model.dart';

class PostActions extends StatelessWidget {
  final PostModel post;

  const PostActions({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser!.uid;
      final isLiked = post.likes!.contains(user);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  post.likes!.length.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.thumb_up,
                    color: isLiked ? Colors.blue : Colors.black,
                  ),
                  label: Text(
                    isLiked ? "Liked" : "Like",
                    style: TextStyle(
                      color: isLiked ? Colors.blue : Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    if (isLiked) {
                      await controller.unLikePost(post);
                    } else {
                      await controller.likePost(post);
                    }

                    await controller.updatePostLikes(post.postId!);
                  },
                ),
              ],
            ),
            FutureBuilder<PostCommentsModel>(
              future: controller.getAllPostComments(postID: post.postId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return TextButton.icon(
                    icon: ImageIcon(
                      AssetImage("assets/images/comment_icon.png"),
                      color: Colors.black,
                    ),
                    label: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: null,
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return TextButton.icon(
                    icon: const ImageIcon(
                      AssetImage("assets/images/comment_icon.png"),
                      color: Colors.black,
                    ),
                    label: const Text(
                      "0 Comments",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => _showCommentsDialog(context, controller),
                  );
                }

                final count = snapshot.data!.comments.length;

                return TextButton.icon(
                  icon: const ImageIcon(
                    AssetImage("assets/images/comment_icon.png"),
                    color: Colors.black,
                  ),
                  label: Text(
                    "$count Comments",
                    style: const TextStyle(color: Colors.black),
                  ),
                  onPressed: () => _showCommentsDialog(context, controller),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  void _showCommentsDialog(BuildContext context, HomeController controller) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        PostCommentsModel? postCommentsModel;
        bool isLoading = true;

        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> loadComments() async {
              setState(() => isLoading = true);
              try {
                postCommentsModel =
                    await controller.getAllPostComments(postID: post.postId!);
              } catch (e) {
                if (kDebugMode) print("Error loading comments: $e");
              }
              setState(() => isLoading = false);
            }

            // Initial load
            if (isLoading && postCommentsModel == null) {
              loadComments();
            }

            return Dialog(
              insetPadding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text(
                      'Comments',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : postCommentsModel == null
                              ? const Center(
                                  child: Text('Error loading comments'))
                              : postCommentsModel!.comments.isEmpty
                                  ? const Center(
                                      child: Text('No Comments yet.'))
                                  : ListView.builder(
                                      itemCount:
                                          postCommentsModel!.comments.length,
                                      itemBuilder: (context, index) {
                                        final comment =
                                            postCommentsModel!.comments[index];

                                        return FutureBuilder<
                                            Map<String, dynamic>?>(
                                          future: controller.getUserDataByUid(
                                              comment.firebaseUid),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const ListTile(
                                                leading: CircleAvatar(
                                                    child:
                                                        CircularProgressIndicator()),
                                                title: Text("Loading..."),
                                              );
                                            } else if (snapshot.hasError ||
                                                !snapshot.hasData ||
                                                snapshot.data == null) {
                                              return const ListTile(
                                                leading: CircleAvatar(
                                                    child: Icon(Icons.error)),
                                                title: Text("Unknown User"),
                                                subtitle: Text(
                                                    "Could not load user data."),
                                              );
                                            }

                                            final userData = snapshot.data!;
                                            final profilePic = userData[
                                                    'profilePic'] ??
                                                'https://via.placeholder.com/150';
                                            final username =
                                                userData['username'] ??
                                                    'Unknown User';

                                            return ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(profilePic),
                                              ),
                                              title: Text(
                                                username,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(comment.text),
                                              trailing: Text(
                                                DateFormatter
                                                    .getSuitableDateString(
                                                        comment.createdAt,
                                                        true),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: 'Write a comment...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            final text = commentController.text.trim();
                            if (text.isNotEmpty) {
                              commentController.clear();
                              await controller.addComment(
                                postId: post.postId!,
                                commentText: text,
                              );

                              await loadComments();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
