import 'package:Helios/bloc/user/events/user_init_event.dart';
import 'package:Helios/bloc/user/state/user_state.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/bloc/user/events/user_event.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/server/high_level/refresh_tokens.dart';
import 'package:Helios/repository/user/get_user.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserInit>(onInit);
    
  }

  Future<void> onInit(UserEvent event, Emitter emit) async{
  final User user = getUser();

  if (user.validity != UserValidity.notValid) {
    final Auth status = await refresh(user);
    emit(UserState())
  }
}
}

