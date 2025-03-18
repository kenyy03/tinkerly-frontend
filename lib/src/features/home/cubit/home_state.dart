part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState({
    this.usersHome = const []
  });

  final List<UserPublic> usersHome;
  @override
  List<Object> get props => [usersHome];
}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {
  final String message;

  const HomeLoading({super.usersHome, required this.message});
}
final class HomeFailure extends HomeState {
  final String messageError;

  const HomeFailure({required this.messageError}) : super();
}
final class UsersHomeObtained extends HomeState {
  final List<UserPublic> usersHomeObtained;

  const UsersHomeObtained({required this.usersHomeObtained}) 
    : super(usersHome: usersHomeObtained);
}


