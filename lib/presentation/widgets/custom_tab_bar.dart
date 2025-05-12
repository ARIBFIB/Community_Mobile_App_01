import 'package:flutter/material.dart';
import 'package:companio_community_chat_firebase/presentation/widgets/theme/style.dart';

class CustomTabBar extends StatelessWidget {
  final int index;

  const CustomTabBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: primaryColor),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: "CHATS",
              textColor: index == 1 ? textIconColor ?? Colors.black : textIconColorGray ?? Colors.grey, // Provide fallback color if the color is null
              borderColor: index == 1 ? textIconColor ?? Colors.black : Colors.transparent,  // Provide fallback color if the color is null
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: "STATUS",
              textColor: index == 2 ? textIconColor ?? Colors.black : textIconColorGray ?? Colors.grey, // Provide fallback color if the color is null
              borderColor: index == 2 ? textIconColor ?? Colors.black : Colors.transparent,  // Provide fallback color if the color is null
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: "CALLS",
              textColor: index == 3 ? textIconColor ?? Colors.black : textIconColorGray ?? Colors.grey, // Provide fallback color if the color is null
              borderColor: index == 3 ? textIconColor ?? Colors.black : Colors.transparent,  // Provide fallback color if the color is null
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  const CustomTabBarButton({
    Key? key,
    required this.text,
    required this.borderColor,
    required this.textColor,
    this.borderWidth=3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor, width: borderWidth),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
