import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim/core/colors/my_colors.dart';
import 'package:muslim/core/images/my_images.dart';
import 'package:muslim/core/router/router_path.dart';
import '../../../../core/app_stirings/app_strings.dart';
import '../../../../core/sizes/app_sizes.dart';
import '../../cubit/surahs_cubit.dart';
import '../../model/surah_model.dart';

class SurahListPage extends StatefulWidget {
  const SurahListPage({Key? key}) : super(key: key);

  @override
  SurahListPageState createState() => SurahListPageState();
}

class SurahListPageState extends State<SurahListPage> {
  late QuranCubit quranCubit;
  late List<SurahCardData> surahList;
  late List<SurahCardData> filteredSurahList;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    quranCubit = context.read<QuranCubit>();
    surahList = quranCubit.surahList;
    filteredSurahList = surahList;
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchSurah(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSurahList = surahList;
      } else {
        filteredSurahList = surahList.where((surah) {
          final surahName = surah.name.toLowerCase();
          final searchQuery = query.toLowerCase();
          return surahName.contains(searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(MySizes.s15 * 1.1),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: searchSurah,
              decoration: InputDecoration(
                filled: true,
                fillColor: MyColors.background,
                hintText: AppStrings.searchAboutSurah,
                suffixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: MySizes.s10 * 1.2, horizontal: MySizes.s15 * 1.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MySizes.s15 * .5),
                  borderSide: const BorderSide(color: MyColors.background),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(MySizes.s15 * .5),
                ),
              ),
            ),
            const SizedBox(height: MySizes.s15 * 1.1),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredSurahList.length,
                itemBuilder: (context, index) {
                  final surah = filteredSurahList[index];
                  return buildSurahCard(context, surah, quranCubit);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildSurahCard(
      BuildContext context, SurahCardData surah, QuranCubit quranCubit) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MySizes.s10),
      ),
      child: InkWell(
        onTap: () {
          // Handle surah item tap
          // You can navigate to a detailed surah page, for example
          quranCubit.currentSurah = surah.name;
          quranCubit.currentSurahIndex = surah.surahCount;
          quranCubit.getAyatOfSurah(surah.surahCount);
          quranCubit.currentHighlitedAyahIndex = -1;
          Navigator.of(context).pushNamed(RoutePaths.surahDetails);
          quranCubit.controller = ScrollController();
        },
        child: Padding(
          padding: const EdgeInsets.all(MySizes.s15 * .5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(MyImages.quranIcon()),
              const SizedBox(width: MySizes.s15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.name,
                      style: const TextStyle(
                          fontSize: MySizes.s15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: MySizes.s15 * .25),
                    Text(
                      '${AppStrings.surahNumber}: ${surah.surahCount}',
                      style: const TextStyle(fontSize: MySizes.s15),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: MySizes.s15 * .5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    surah.type,
                    style: const TextStyle(
                        fontSize: MySizes.s15, color: MyColors.primaryColor),
                  ),
                  const SizedBox(height: MySizes.s15 * .25),
                  Text(
                    '${AppStrings.ayahCounts}: ${surah.verseCount}',
                    style: const TextStyle(fontSize: MySizes.s15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
