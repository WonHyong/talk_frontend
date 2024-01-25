import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/preferences.dart';

import 'src/app.dart';

void main() async {
  await SharedPrefs().init();
  runApp(const MyApp());
}
