part of 'switch_cubit.dart';

sealed class SwitchState extends Equatable {
  const SwitchState({ this.isActive = false });
  final bool isActive;

  @override
  List<Object> get props => [isActive];
}

final class SwitchInitial extends SwitchState {
  final bool isActiveSwitch;
  const SwitchInitial({ required this.isActiveSwitch })
    : super(isActive: isActiveSwitch);
}

final class SwitchChanged extends SwitchState {
  final bool isActiveSwitch;
  const SwitchChanged({ required this.isActiveSwitch }) 
    : super(isActive: isActiveSwitch);
}
