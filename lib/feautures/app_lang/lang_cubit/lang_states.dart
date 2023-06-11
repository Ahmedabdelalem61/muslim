import 'package:flutter/foundation.dart';


@immutable
abstract class AppLanguageState {}

class AppLanguageInitial extends AppLanguageState {}

class AppChangeLanguage extends AppLanguageState {
  AppChangeLanguage({
    required this.locale,
  });
  final String locale;
}