part of 'welcome_bloc.dart';

enum AppInitStatus {
  loading,
  failed,
  userNotSufficient,
  success,
}

@immutable
class WelcomeState extends Equatable {
  const WelcomeState({required this.appInitStatus});

  final AppInitStatus? appInitStatus;

  const WelcomeState.empty() : appInitStatus = null;

  WelcomeState copyWith({AppInitStatus? appInitStatus}) => WelcomeState(
        appInitStatus: appInitStatus ?? this.appInitStatus,
      );

  @override
  List<Object?> get props => [appInitStatus];
}
