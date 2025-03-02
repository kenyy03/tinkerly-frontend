import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required IAuthRepository authRepository}) 
    : _authRepository = authRepository, 
    super(HomeInitial());

  final IAuthRepository _authRepository;

  void getUsersHome() async {
    try {
      emit(HomeLoading(message: 'Cargando Perfiles...'));
      final userResponse = await _authRepository.getUserForHomeResume();
      emit(UsersHomeObtained(usersHomeObtained: userResponse));
    } catch (e) {
      HomeFailure(messageError: e.toString());
    }
  }
}
