import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRequested) {
      yield* _mapLoginRequestedToState(event.username, event.password);
    }
  }

  Stream<LoginState> _mapLoginRequestedToState(
      String username, String password) async* {
    if (username == "admin" && password == "password") {
      yield LoginSuccess();
    } else {
      yield LoginFailure("Invalid username or password");
    }
  }
}
