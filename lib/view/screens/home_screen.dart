import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/enums.dart';
import '../../core/view_model/home_controller.dart';
import '../widgets/home_widgets/home_search_bar.dart';
import '../widgets/home_widgets/post_widgets/posts_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (controller.getAllPostsState == FutureState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              HomeSearchBar(controller: controller),
              const SizedBox(height: 30),
              PostsList(controller: controller),
            ],
          ),
        );
      },
    );
  }
}
