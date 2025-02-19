import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'image_picker_profile_state.dart';

class ImagePickerProfileCubit extends Cubit<ImagePickerProfileState> {
  final IAuthRepository _repository;
  ImagePickerProfileCubit({ required IAuthRepository repository }) : _repository = repository, super(ImagePickerProfileInitial());

  void onTakePhoto({required String imagePath}){
    if(imagePath.isEmpty){
      return;
    }
    emit(ImageProfileOnTakedPhoto(imageProfilePath: imagePath));
  }

  void onSelectedPhotoFromGallery({required String imagePath}){
    if(imagePath.isEmpty){
      return;
    }
    emit(ImageProfileOnSelectedPhoto(imageProfilePath: imagePath));
  }

  void onUploadImageProfile({required File file, required String id}) async {
    try {
      if(file.path.isEmpty){
        return;
      }
      emit(ImageProfileLoading(imageProfilePath: state.imageProfilePath));
      final response = await _repository.uploadImageProfile(file: file, id: id);

      emit(ImageProfileUploaded(imageProfilePath: response.imageProfile.url));
    } catch (e) {
      emit(ImageProfileFailure(messageError: e.toString()));
    }
  }
}
