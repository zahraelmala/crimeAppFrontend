import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCloseButton extends StatelessWidget {
  final double? radius;
  final double? padding;
  const CustomCloseButton({
    super.key,
    this.radius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.close(1),
      child: Container(
        padding: EdgeInsets.all(padding ?? 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5),
          border: Border.all(
            color: const Color(0xffEBEBEB),
            width: 1,
          ),
        ),
        child: const Icon(Icons.close, color: Colors.red),
      ),
    );
  }
}
