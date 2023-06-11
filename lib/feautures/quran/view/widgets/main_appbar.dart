import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/sizes/app_sizes.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget title;
  final TabBar tabBar;
  final String backgroundImage;

  const MainAppBar({
    super.key,
    this.height = kToolbarHeight + MySizes.s10 * 5, // Increased height by 50.0
    required this.title,
    required this.tabBar,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          backgroundImage,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: title,
          centerTitle: true,
          bottom: tabBar,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
