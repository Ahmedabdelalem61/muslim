import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim/core/colors/my_colors.dart';
import 'package:muslim/core/images/my_images.dart';
import '../../cubit/surahs_cubit.dart';

class QuranDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final QuranCubit quranCubit;

  const QuranDetailsAppBar(this.quranCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: MyColors.primaryColor,
      title: Text(
        quranCubit.currentSurah,
      ),
      flexibleSpace: Stack(
        children: [
          SvgPicture.asset(
            MyImages.appbarBackground(), // Replace with your SVG image path
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
