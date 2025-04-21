import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/enums.dart';
import '../../core/view_model/profile_controller.dart';
import '../widgets/profile_widgets/my_posts_list.dart';

class YourPostsScreen extends StatefulWidget {
  const YourPostsScreen({super.key});

  @override
  State<YourPostsScreen> createState() => _YourPostsScreenState();
}

class _YourPostsScreenState extends State<YourPostsScreen> {
  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Your posts', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        switch (controller.getAllPostsState.value) {
          case FutureState.loading:
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          case FutureState.failed:
            return Center(
              child: Text('Failed to fetch posts', style: TextStyle(color: Colors.red)),
            );
          case FutureState.success:
            if (controller.myPosts.isEmpty) {
              return Center(
                child: Text('No Posts Found', style: TextStyle(color: Colors.red)),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(child: MyPostsList()), // Wrapped with Expanded here
                ],
              ),
            );
          case FutureState.initial:
            return Center(child: Text('Loading...'));
        }
      }),
    );
  }
}
