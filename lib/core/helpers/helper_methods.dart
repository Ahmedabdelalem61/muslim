import 'package:flutter/material.dart';

void closeKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}