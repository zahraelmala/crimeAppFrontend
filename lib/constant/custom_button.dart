import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Function(bool)? onHover;
  final Color buttonColor;
  final Color textColor;
  final Color? hoverColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? textSize;
  final IconData? icon;
  final Color? iconColor;
  final Color? borderColor;
  final bool? isIcon;
  final bool? isIconRight;
  final bool? isSpaceEven;
  final EdgeInsetsGeometry? padding;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.onHover,
    this.hoverColor,
    this.width,
    required this.buttonColor,
    required this.textColor,
    this.borderRadius,
    this.borderColor,
    this.textSize,
    this.height,
    this.icon,
    this.isIcon,
    this.isIconRight,
    this.isSpaceEven,
    this.iconColor,
    this.padding,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return isIconRight == true
        ? InkWell(
            onTap: onTap,
            onHover: onHover,
            hoverColor: hoverColor,
            child: Container(
              width: width ?? 200,
              height: height ?? 48,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor ?? buttonColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
                color: buttonColor,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: textSize ?? 16.0,
                        fontWeight: fontWeight,
                      ),
                    ),
                    if (isIcon == true) ...[
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        icon,
                        color: iconColor,
                      ),
                    ]
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: onTap,
            onHover: onHover,
            hoverColor: hoverColor,
            child: Container(
              width: width ?? 200,
              height: height ?? 48,
              padding: padding,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor ?? buttonColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
                color: buttonColor,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isIcon == true) ...[
                      Icon(
                        icon,
                        color: iconColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: textSize ?? 16.0,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
