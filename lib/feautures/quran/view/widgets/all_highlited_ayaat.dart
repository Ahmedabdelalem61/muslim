import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/router_path.dart';
import '../../../../core/sizes/app_sizes.dart';
import '../../cubit/surahs_cubit.dart';
import '../../model/highlited_ayah.dart';

class ReorderableHighlightedAyatPage extends StatelessWidget {
  const ReorderableHighlightedAyatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quranCubit = context.read<QuranCubit>();
    return Padding(
      padding: const EdgeInsets.all(MySizes.s15 * 1.1),
      child: ReorderableListView.builder(
        onReorder: (int oldIndex, int newIndex) {
          quranCubit.reorderHighlightedAyahs(oldIndex, newIndex);
        },
        itemBuilder: (BuildContext context, int index) {
          final highlightedAyah = quranCubit.highlitedAyaht[index];
          return _buildCard(
              context, highlightedAyah, Key('$index'), quranCubit);
        },
        itemCount: quranCubit.highlitedAyaht.length,
      ),
    );
  }

  Widget _buildCard(BuildContext context, HighlightedAyah highlightedAyah,
      Key key, QuranCubit quranCubit) {
    return Card(
      key: key,
      child: ListTile(
        title: Text(highlightedAyah.ayahText),
        subtitle: Text(highlightedAyah.surat),
        onTap: () {
          quranCubit.currentSurah = highlightedAyah.surat;
          quranCubit.currentSurahIndex = highlightedAyah.surahNumber;
          quranCubit.getAyatOfSurah(highlightedAyah.surahNumber);
          quranCubit.currentHighlitedAyahIndex = highlightedAyah.ayahIndex;
          quranCubit.controller =
              ScrollController(initialScrollOffset: highlightedAyah.offsest);
          Navigator.of(context).pushNamed(RoutePaths.surahDetails);
        },
      ),
    );
  }
}
