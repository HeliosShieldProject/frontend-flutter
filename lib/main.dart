import 'package:flutter/material.dart';
import 'package:helios/app/ui/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  runApp(const App());
}