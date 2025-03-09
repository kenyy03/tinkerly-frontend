part of 'professional_cubit.dart';

sealed class ProfessionalState extends Equatable {
  const ProfessionalState({this.usersPublic = const []});
  final List<UserPublic> usersPublic;
  @override
  List<Object> get props => [usersPublic];
}

final class ProfessionalInitial extends ProfessionalState {}

final class ProfessionalsObtained extends ProfessionalState {
  final List<UserPublic> usersPublicObtained;
  const ProfessionalsObtained({ required this.usersPublicObtained }) 
    : super(usersPublic: usersPublicObtained);
}

final class ProfessionalsLoading extends ProfessionalState {
  final String message;
  const ProfessionalsLoading({ this.message = 'Cargando...', super.usersPublic }) ;
}

final class ProfessionalFailure extends ProfessionalState {
  final String messageError;
  const ProfessionalFailure({this.messageError = 'Internal Server Error'});
}


