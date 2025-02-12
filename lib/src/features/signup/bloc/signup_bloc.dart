import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final IAuthRepository _repository;
  SignupBloc(IAuthRepository repository) : _repository = repository, super(SignupInitial()) {
    
    on<NamesOnChanged>(_namesChanged);
    on<LastNamesOnChanged>(_lastNamesChanged);
    on<EmailOnChanged>(_emailChanged);
    on<PhoneOnChanged>(_phoneChanged);
    on<PasswordOnChanged>(_passwordChanged);
    on<CreateAccountPressed>(_createAccount);
  }

  void _createAccount(CreateAccountPressed event, Emitter<SignupState> emit) async {
    try {
      print(state.user.names);
      emit(SignUpLoading(mensaje: 'Creando nuevo usuario...', user: state.user));
      final response = await _repository.signUp(user: state.user);
      emit(UserCreatedSuccess(user: response));
    } catch (e) {
      emit(SignUpFailure(mensajeError: e.toString()));
    }
  }

  void _namesChanged(NamesOnChanged event, Emitter<SignupState> emit){
    emit(UserFilled(user: state.user.copyWith(names: event.names)));
  }

  void _lastNamesChanged(LastNamesOnChanged event, Emitter<SignupState> emit){
    emit(UserFilled(user: state.user.copyWith(lastNames: event.lastNames)));
  }

  void _emailChanged(EmailOnChanged event, Emitter<SignupState> emit){
    emit(UserFilled(user: state.user.copyWith(email: event.email)));
  }

  void _phoneChanged(PhoneOnChanged event, Emitter<SignupState> emit){
    emit(UserFilled(user: state.user.copyWith(phone: event.phone)));
  }

  void _passwordChanged(PasswordOnChanged event, Emitter<SignupState> emit){
    emit(UserFilled(user: state.user.copyWith(password: event.password)));
  }
}
