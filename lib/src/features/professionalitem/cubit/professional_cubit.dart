import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'professional_state.dart';

class ProfessionalCubit extends Cubit<ProfessionalState> {
  final IAuthRepository _authRepository;
  ProfessionalCubit({ required IAuthRepository authRepository }) 
    : _authRepository = authRepository, 
    super(ProfessionalInitial());

    void getPublicUsers() async {
      try {
        emit(ProfessionalsLoading(message: 'Obteniedo perfiles...', usersPublic: state.usersPublic));
        final response = await _authRepository.getUsersByIsPublicProfile();
        emit(ProfessionalsObtained(usersPublicObtained: response));
      } catch (e) {
        emit(ProfessionalFailure(messageError: e.toString()));
      }
    }
}
