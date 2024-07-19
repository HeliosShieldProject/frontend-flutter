import 'package:flutter/material.dart';
import 'package:helios/app/ui/app.dart';
import 'package:helios/common/user_settings/user_settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(UserSettingsImplAdapter());
  Hive.registerAdapter(SubscriptionTypeAdapter());
  Hive.registerAdapter(SelectedThemeAdapter());
  runApp(const App());
}