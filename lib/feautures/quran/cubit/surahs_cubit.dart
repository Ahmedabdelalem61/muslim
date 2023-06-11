import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/feautures/quran/cubit/states.dart';
import 'package:quran/quran.dart' as quran;

import '../model/highlited_ayah.dart';
import '../model/surah_model.dart';

class QuranCubit extends Cubit<AllSurahsStates> {
  QuranCubit() : super(InitialSurahs());

  List<SurahCardData> surahList = [];
  List<HighlightedAyah> highlitedAyaht = [];
  List<String> ayatList = [];
  ScrollController controller = ScrollController();
  double fontSize = 26.0;



  Map<String, String> placeOfTanzeel = {
    "Makkah": "مكه",
    "Madinah": "المدينه",
  };

  String currentSurah = "";
  int currentSurahIndex = 0;
  int currentHighlitedAyahIndex = -1;


  void loadSurahList() {
    emit(AllSurahsLoading());

    for (int i = 1; i <= 114; i++) {
      surahList.add(SurahCardData(
        name: quran.getSurahNameArabic(i),
        verseCount: quran.getVerseCount(i),
        type: placeOfTanzeel[quran.getPlaceOfRevelation(i)] ?? "",
        surahCount: i,
      ));
    }
    emit(GetAllSurahs());
  }

  void getAyatOfSurah(int surahtIndex) {
    ayatList.clear();
    List<int> pagesCount = quran.getSurahPages(surahtIndex);
    for (var pageNumber in pagesCount) {
      var ayatInPage = quran.getVersesTextByPage(pageNumber);
      if (kDebugMode) {
        print(ayatInPage);
      }
      ayatList.addAll(ayatInPage);
    }
  }


  // Reorder the highlighted ayahs based on the old and new indexes
  void reorderHighlightedAyahs(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final highlightedAyah = highlitedAyaht.removeAt(oldIndex);
    highlitedAyaht.insert(newIndex, highlightedAyah);

    emit(GetAllSurahs());
  }

  void addNewAyahHighliting(HighlightedAyah highlightedAyah,context) {
    highlitedAyaht.add(highlightedAyah);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          " تم تدوين الآية: ${highlightedAyah.ayahText}",
        ),
      ),
    );
    emit(HighlitAyahState());
  }

  double get getFontSize => fontSize;

  void changeFontSize(double value) {
    fontSize = value;
    emit(ChangeFontStateState());
  }
}



