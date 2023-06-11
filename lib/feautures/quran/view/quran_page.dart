import 'package:flutter/material.dart';
import 'package:muslim/core/colors/my_colors.dart';
import 'package:muslim/feautures/quran/view/widgets/all_highlited_ayaat.dart';
import 'package:muslim/feautures/quran/view/widgets/all_surahs_page.dart';
import 'package:muslim/feautures/quran/view/widgets/main_appbar.dart';
import '../../../core/app_stirings/app_strings.dart';
import '../../../core/images/my_images.dart';

class QuranKareemPage extends StatelessWidget {
  const QuranKareemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(
          title: const Text(AppStrings.quranKareem),
          tabBar: const TabBar(
            dividerColor: MyColors.primaryColor,
            indicatorColor: MyColors.primaryColor,
            tabs: [
              Tab(text: AppStrings.allSurhas),
              Tab(text: AppStrings.highlited),
            ],
          ),
          backgroundImage: MyImages.appbarBackground(),
        ),
        body: const TabBarView(
          children: [SurahListPage(), ReorderableHighlightedAyatPage()],
        ),
      ),
    );
  }
}
