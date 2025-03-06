import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/services.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  final IAuthRepository _repository;
  SwitchCubit({ required IAuthRepository repository }) 
    : _repository = repository, 
    super(SwitchInitial(isActiveSwitch: UserStorage().get('user')!.isPublicProfile));

  void publishProfile({ required bool isPublicProfile, required String userId }) async {
    try {
      final response = await _repository.publishProfile(
        isPublicProfile: isPublicProfile, 
        userId: userId,
      );

      emit(SwitchChanged(isActiveSwitch: response.isPublicProfile));
    } catch (e) {
      emit(SwitchChanged(isActiveSwitch: false));
    }
  }
}
