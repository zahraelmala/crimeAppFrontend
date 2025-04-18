import 'package:a/core/view_model/home_controller.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final HomeController controller;
  const HomeSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: controller.filterPosts,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
