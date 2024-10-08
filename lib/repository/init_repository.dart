import 'package:hive_flutter/hive_flutter.dart';
import 'package:Helios/repository/hive_keys.dart';

import 'package:Helios/common/user/user_impl.dart';
import 'package:Helios/bloc/user_settings/state/user_settings_impl.dart';
import 'package:Helios/common/countries/country_impl.dart';

import 'package:Helios/features/vpn_app/domain/vpn/enums/enums.dart';
import 'package:Helios/features/vpn_app/domain/vpn/models/vpn_status.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/interfaces.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive
    ..registerAdapter(UserSettingsImplAdapter())
    ..registerAdapter(UserImplAdapter())
    ..registerAdapter(SubscriptionTypeAdapter())
    ..registerAdapter(SelectedThemeAdapter())
    ..registerAdapter(VPNStatusAdapter())
    ..registerAdapter(StatusAdapter())
    ..registerAdapter(ProtocolAdapter())
    ..registerAdapter(CountryImplAdapter());

  await Hive.openBox<UserSettings>(HiveKeys.userBox);
  await Hive.openBox<User>(HiveKeys.userSettingsBox);
}
