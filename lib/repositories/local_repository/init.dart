import 'package:hive_flutter/hive_flutter.dart';

import 'package:Helios/repositories/local_repository/hive_keys.dart';

import 'package:Helios/repositories/local_repository/user/models/user_impl.dart';
import 'package:Helios/repositories/local_repository/user_settings/models/user_settings_impl.dart';
import 'package:Helios/common/countries/country_impl.dart';

import 'package:Helios/repositories/local_repository/vpn/models/ip.dart';
import 'package:Helios/repositories/local_repository/vpn/models/vpn_connection.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/interfaces.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive
    ..registerAdapter(UserSettingsImplAdapter())
    ..registerAdapter(SubscriptionTypeAdapter())
    ..registerAdapter(SelectedThemeAdapter())
    ..registerAdapter(UserImplAdapter())
    ..registerAdapter(CountryImplAdapter())
    ..registerAdapter(ProtocolsAdapter())
    ..registerAdapter(IPAdapter())
    ..registerAdapter(VpnConnectionAdapter());

  await Hive.openBox<UserSettings>(HiveKeys.userBox);
  await Hive.openBox<User>(HiveKeys.userSettingsBox);
}
