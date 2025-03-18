import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/services.dart';
import 'package:mobile_frontend/src/features/profilemenu/components/profile_square_tile.dart';
import 'package:mobile_frontend/src/features/profilemenu/cubits/imageprofilecubit/image_picker_profile_cubit.dart';
import 'package:mobile_frontend/src/features/reviews/cubit/review_cubit.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';

class ProfileHeaderOptions extends StatelessWidget {
  const ProfileHeaderOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    onTapOpenManagePhoto() async {
      final ImageDto result = await UiUtil.openBottomSheet(
          context: context,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.35),
          widget: _ManagmentProfilePhoto());
      if (context.mounted) {
        if (result.esEliminarFoto) {
          context
              .read<ImagePickerProfileCubit>()
              .onDeleteImageProfileUrl(isDelete: result.esEliminarFoto);
        } else {
          context
              .read<ImagePickerProfileCubit>()
              .onSelectedPhotoFromGallery(imagePath: result.path);
        }
      }
    }

    final currentUser = UserStorage().get('user');
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewsObtained) {
          context.push(
              '${AppRoutes.profileItems}${AppRoutes.profileDetails}${AppRoutes.review}',
              extra: json.encode(
                  state.reviewsObtained.map((e) => e.toJson()).toList()));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.padding),
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppDefaults.borderRadius,
          boxShadow: AppDefaults.boxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileSquareTile(
              label: 'Propuestas',
              icon: AppIcons.fileContract,
              onTap: () {},
            ),
            ProfileSquareTile(
              label: 'Foto',
              icon: AppIcons.cameraOutlined,
              onTap: onTapOpenManagePhoto,
            ),
            BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, state) {
                return state is! ReviewLoading 
                ? ProfileSquareTile(
                  label: 'Reseñas',
                  icon: AppIcons.review,
                  onTap: () {
                    context
                        .read<ReviewCubit>()
                        .getReviewsByUser(userId: currentUser!.id);
                  },
                ) : CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagmentProfilePhoto extends StatelessWidget {
  _ManagmentProfilePhoto();

  final _imagePicker = CameraService();

  @override
  Widget build(BuildContext context) {
    void openCameraToTakePhoto() async {
      String? imagePath = await _imagePicker.takePhoto();
      if (context.mounted) {
        context.pop(ImageDto(path: imagePath ?? '', esEliminarFoto: false));
      }
    }

    void openGalleryToSelectPhoto() async {
      String? imagePath;
      imagePath = await _imagePicker.selectPhoto();
      if (context.mounted) {
        context.pop(ImageDto(path: imagePath ?? '', esEliminarFoto: false));
      }
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(AppDefaults.margin),
          padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Editar foto de perfil',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () =>
                      context.pop(ImageDto(path: '', esEliminarFoto: false)),
                  icon: Icon(Icons.close))
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: AppDefaults.borderRadius,
              color: Theme.of(context).hoverColor),
          margin: EdgeInsets.symmetric(horizontal: AppDefaults.margin),
          // padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                title: const Text('Tomar foto'),
                trailing: Icon(
                  Icons.camera_alt_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: openCameraToTakePhoto,
              ),
              Divider(thickness: 0.1),
              ListTile(
                title: const Text('Escoger foto'),
                trailing: Icon(Icons.image_outlined,
                    color: Theme.of(context).colorScheme.primary),
                onTap: openGalleryToSelectPhoto,
              ),
              Divider(thickness: 0.1),
              ListTile(
                title: const Text('Eliminar Foto',
                    style: TextStyle(color: Colors.red)),
                trailing: const Icon(Icons.delete_outlined, color: Colors.red),
                onTap: () =>
                    context.pop(ImageDto(path: '', esEliminarFoto: true)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
