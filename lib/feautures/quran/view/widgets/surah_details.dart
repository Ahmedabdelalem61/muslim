import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/colors/my_colors.dart';
import 'package:muslim/feautures/quran/view/widgets/quran_details_appbar.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/sizes/app_sizes.dart';
import '../../cubit/states.dart';
import '../../cubit/surahs_cubit.dart';
import '../../model/highlited_ayah.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quranCubit = context.read<QuranCubit>();
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: QuranDetailsAppBar(quranCubit),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: quranCubit.controller,
          child: BlocBuilder<QuranCubit, AllSurahsStates>(
            builder: (context, state) {
              return Column(
                children: [
                  Slider(
                    activeColor: MyColors.primaryColor,
                    inactiveColor: MyColors.primaryColor.withOpacity(.2),
                    value: quranCubit.getFontSize,
                    min: MySizes.s10,
                    max: MySizes.s10 * 4,
                    onChanged: (value) {
                      quranCubit.changeFontSize(value);
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onLongPress: () {},
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: MyColors.quranTextColor,
                            fontSize: quranCubit.getFontSize,
                            height: 1.7,
                          ),
                          children: quranCubit.ayatList
                              .asMap()
                              .entries
                              .map((entry) {
                                final i = entry.key;
                                final ayah = entry.value;
                                final isHighlighted =
                                    i == quranCubit.currentHighlitedAyahIndex;

                                return [
                                  TextSpan(
                                    text: ayah,
                                    style: TextStyle(
                                      color: isHighlighted
                                          ?MyColors.highlitedColor
                                          : MyColors.quranTextColor,
                                    ),
                                    recognizer: LongPressGestureRecognizer()
                                      ..onLongPress = () {
                                        quranCubit.addNewAyahHighliting(
                                          HighlightedAyah(
                                            ayahIndex: i,
                                            ayahText: ayah,
                                            surat: quranCubit.currentSurah,
                                            ayatCounter:
                                                quranCubit.ayatList.length,
                                            surahNumber:
                                                quranCubit.currentSurahIndex,
                                            offsest:
                                                quranCubit.controller.offset,
                                          ),
                                          context,
                                        );
                                      },
                                  ),
                                  TextSpan(
                                    text: quran.getVerseEndSymbol(i + 1),
                                  ),
                                ];
                              })
                              .expand((element) => element)
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
