import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'professionaldetails_state.dart';

class ProfessionaldetailsCubit extends Cubit<ProfessionaldetailsState> {
  ProfessionaldetailsCubit() : super(ProfessionaldetailsInitial());
}
