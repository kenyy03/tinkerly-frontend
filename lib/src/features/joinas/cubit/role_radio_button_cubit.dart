import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'role_radio_button_state.dart';

class RoleRadioButtonCubit extends Cubit<RoleRadioButtonState> {
  RoleRadioButtonCubit(IRoleRepository repository) 
    : _repository=repository, super(RoleRadioButtonInitial()) ;
  
  final IRoleRepository _repository;

  void selectRadioButton({required List<Role> roles}){
    emit(RoleRadioButtonSelected(roles: roles));
  }

  void getRoles()async{
    emit(RoleLoading(roles: state.roles, message: 'Loading Roles...'));
    final roles = await _repository.getRoles();
    emit(RoleRadioButtonSelected(roles: roles));  
  }
}
