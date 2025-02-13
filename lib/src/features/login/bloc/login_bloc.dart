import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository _repository;
  LoginBloc(IAuthRepository repository) : _repository = repository,  super(LoginInitial()) {
    on<LoginPressed>(_loginOnPress);
  }

  void _loginOnPress(LoginPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading(mensaje: 'Creando nuevo usuario...', user: state.user));
      final response = await _repository.login(email: event.email, password: event.password);
      emit(UserAutenticateSuccess(user: response));
    } catch (e) {
      emit(LoginFailure(mensajeError: e.toString()));
    }
  }
}
