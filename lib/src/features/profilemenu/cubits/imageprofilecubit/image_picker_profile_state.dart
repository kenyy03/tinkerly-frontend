part of 'image_picker_profile_cubit.dart';

sealed class ImagePickerProfileState extends Equatable {
  const ImagePickerProfileState({String? imageProfilePath}) : imageProfilePath = imageProfilePath ?? '';
  final String imageProfilePath;

  @override
  List<Object> get props => [imageProfilePath];
}

final class ImagePickerProfileInitial extends ImagePickerProfileState {}
final class ImageProfileOnTakedPhoto extends ImagePickerProfileState {
  const ImageProfileOnTakedPhoto({super.imageProfilePath});
}
final class ImageProfileOnSelectedPhoto extends ImagePickerProfileState {
  const ImageProfileOnSelectedPhoto({super.imageProfilePath});
}
final class ImageProfileFailure extends ImagePickerProfileState {
  final String messageError;
  const ImageProfileFailure({this.messageError = 'Internal Server Error'});
}
final class ImageProfileLoading extends ImagePickerProfileState {
  final String message;
  const ImageProfileLoading({this.message = 'Subiendo imagen', super.imageProfilePath});
}

final class ImageProfileUploaded extends ImagePickerProfileState {
  const ImageProfileUploaded({super.imageProfilePath});
}
