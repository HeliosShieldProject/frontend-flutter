import 'dart:async';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/interfaces.dart';
import 'package:Helios/repositories/local_repository/user_settings/models/user_settings_impl.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/user_settings_repository/user_settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "event.dart";
part "state.dart";

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
      {required this.userRepository, required this.userSettingsRepository})
      : super(const SettingsState.unknown()
            .copyWith(email: userRepository.get().email)) {
    _userSettingsSubscription =
        userSettingsRepository.stream.listen(_userSettingsRepositoryListener);
    userSettingsRepository.init();

    on<_ChangeSettingsEvent>(_onChangeSettingsEvent);
    on<ChangeSelectedThemeEvent>(_onChangeSelectedThemeEvent);
  }

  final UserRepository userRepository;
  final UserSettingsRepository userSettingsRepository;
  late final StreamSubscription<UserSettings> _userSettingsSubscription;

  void _userSettingsRepositoryListener(UserSettings userSettings) {
    add(_ChangeSettingsEvent(userSettings: userSettings));
  }

  void _onChangeSettingsEvent(
      _ChangeSettingsEvent event, Emitter<SettingsState> emit) {
    final SelectedTheme selectedTheme = event.userSettings.selectedTheme;
    final SubscriptionType subscriptionType =
        event.userSettings.subscriptionType;

    emit(state.copyWith(
      selectedTheme: selectedTheme,
      subscriptionType: subscriptionType,
    ));
  }

  void _onChangeSelectedThemeEvent(
      ChangeSelectedThemeEvent event, Emitter<SettingsState> emit) {
    final SelectedTheme selectedTheme = event.selectedTheme;

    userSettingsRepository.put(
        userSettings: UserSettingsImpl(
      selectedTheme: selectedTheme,
      subscriptionType: state.subscriptionType,
    ));
  }

  @override
  Future<void> close() {
    _userSettingsSubscription.cancel();

    return super.close();
  }
}
