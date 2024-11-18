import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/repositories/user_settings_repository/user_settings_repository.dart';
import 'package:Helios/common/interafces/interfaces.dart';

part 'event.dart';

class SettingsBloc extends Bloc<SettingsEvent, UserSettings> {
  SettingsBloc({required UserSettingsRepository userSettingsRepository})
      : _userSettingsRepository = userSettingsRepository,
        super(userSettingsRepository.get()) {
    on<SettingsChangedThemeEvent>(_onSettingsChangedTheme);
    on<SettingsChangedSubscriptionEvent>(_onSettingsChangedSubscription);
  }

  final UserSettingsRepository _userSettingsRepository;

  void _onSettingsChangedTheme(
      SettingsChangedThemeEvent event, Emitter<UserSettings> emit) {
    final UserSettings newSettings = state.copyWith(
      selectedTheme: event.newTheme,
    );

    _userSettingsRepository.put(userSettings: newSettings);

    emit(newSettings);
  }

  void _onSettingsChangedSubscription(
      SettingsChangedSubscriptionEvent event, Emitter<UserSettings> emit) {
    final UserSettings newSettings = state.copyWith(
      subscriptionType: event.newSubscription,
    );

    _userSettingsRepository.put(userSettings: newSettings);

    emit(newSettings);
  }

  static Widget settingsProvider({required Widget child}) =>
      BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(
          userSettingsRepository: context.read<UserSettingsRepository>(),
        ),
        child: child,
      );
}
