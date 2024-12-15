import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/auth_repository/high_level/refresh_tokens.dart';
import 'package:Helios/repositories/session_repository/entities/get_history_server_entity.dart';
import 'package:Helios/repositories/session_repository/high_level/get_history.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "event.dart";
part "state.dart";

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.userRepository})
      : super(const HistoryState.empty()) {
    on<InitHistoryEvent>(_onInitHistoryEvent);
    on<BottomHitEvent>(_onBottomHitEvent);
  }

  final UserRepository userRepository;

  int limit = 20;
  late int offset = -limit;

  Future<void> _onInitHistoryEvent(
      InitHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: Auth.loading));

    List<HistoryInfo> newHistoryInfo = [...state.historyInfo];

    try {
      final User refreshedUser = await refresh(userRepository.get());
      userRepository.put(user: refreshedUser);
      bool reachedEnd = false;

      while (newHistoryInfo.isEmpty ||
          newHistoryInfo.last.dateTimeOpened
              .isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
        offset += limit;

        final List<HistoryInfo> result = await getHistory(
          user: refreshedUser,
          limit: limit,
          offset: offset,
        );

        newHistoryInfo.addAll(result);

        if (result.isEmpty) {
          reachedEnd = true;
        }
      }

      emit(
        state.add(historyInfo: newHistoryInfo).copyWith(
              status: Auth.success,
              reachedEnd: reachedEnd,
            ),
      );
    } on Auth catch (e) {
      emit(state.copyWith(status: e));
    } catch (e) {
      emit(state.copyWith(status: Auth.failed));
    }
  }

  Future<void> _onBottomHitEvent(
      BottomHitEvent event, Emitter<HistoryState> emit) async {
    if (state.reachedEnd) return;

    try {
      offset += limit;

      final List<HistoryInfo> result = await getHistory(
        user: userRepository.get(),
        offset: offset,
        limit: limit,
      );

      if (result.isEmpty) {
        emit(state.copyWith(status: Auth.success, reachedEnd: true));
      } else {
        emit(
          state.add(historyInfo: result).copyWith(status: Auth.success),
        );
      }
    } on Auth catch (e) {
      emit(state.copyWith(status: e));
    } catch (e) {
      emit(state.copyWith(status: Auth.failed));
    }
  }
}
