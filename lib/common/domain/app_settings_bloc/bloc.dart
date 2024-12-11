import 'dart:async';

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user_settings.dart';
import 'package:Helios/common/theme/utils/get_theme.dart';
import 'package:Helios/repositories/user_settings_repository/user_settings_repository.dart';

part "event.dart";
part "state.dart";

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc({
    required this.userSettingsRepository,
  }) : super(const AppSettingsState.unknown()) {
    _streamSubscription =
        userSettingsRepository.stream.listen(_userSettingsListener);
    userSettingsRepository.init();

    on<_ChangeSettingsEvent>(_onChangeSettingsEvent);
  }

  final UserSettingsRepository userSettingsRepository;
  late final StreamSubscription<UserSettings> _streamSubscription;

  void _userSettingsListener(UserSettings userSettings) {
    add(_ChangeSettingsEvent(userSettings: userSettings));
  }

  void _onChangeSettingsEvent(
      _ChangeSettingsEvent event, Emitter<AppSettingsState> emit) {
    final SelectedTheme selectedTheme = event.userSettings.selectedTheme;
    final SubscriptionType subscriptionType =
        event.userSettings.subscriptionType;

    emit(state.copyWith(
      subscriptionType: subscriptionType,
      selectedTheme: selectedTheme,
    ));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  static Widget appSettingsProvider({required Widget child}) => BlocProvider(
        create: (BuildContext context) => AppSettingsBloc(
          userSettingsRepository: context.read<UserSettingsRepository>(),
        ),
        child: child,
      );
}
