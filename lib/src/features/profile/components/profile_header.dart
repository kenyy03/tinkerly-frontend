import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/stores/user_store.dart';
import 'package:mobile_frontend/src/features/common/components/network_image.dart';
import 'package:mobile_frontend/src/features/profile/components/profile_header_options.dart';
import 'package:mobile_frontend/src/features/profile/cubit/image_picker_profile_cubit.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Positioned(
          top: -13,
          child: Image.asset(
            'assets/images/profile_page_background.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        /// Content
        Column(
          children: [
            AppBar(
              title: const Text('Perfil'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const _UserData(),
            const ProfileHeaderOptions()
          ],
        ),
      ],
    );
  }
}

class _UserData extends StatefulWidget {
  const _UserData();
  // final String userImageProfilePath;

  @override
  State<_UserData> createState() => _UserDataState();
}

class _UserDataState extends State<_UserData> {
  final userStored = UserStorage();
  User? currentUser =
      User(names: '', lastNames: '', email: '', password: '', phone: '');
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() {
    currentUser = userStored.get('user');
    // context.read<ImagePickerProfileCubit>().onTakePhoto(imagePath: currentUser!.imageProfile.url);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImagePickerProfileCubit, ImagePickerProfileState>(
      listener: (context, state) async {
        if(state is ImageProfileOnSelectedPhoto){
          final currentUser = UserStorage().get('user');
          context.read<ImagePickerProfileCubit>().onUploadImageProfile(file: File(state.imageProfilePath), id: currentUser!.id);
        }
        if(state is ImageProfileUploaded){
          currentUser = currentUser!.copyWith(
            imageProfile: currentUser!.imageProfile.copyWith(url: state.imageProfilePath) 
          );
          await Future.delayed(Duration(milliseconds: 150));
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Row(
          children: [
            const SizedBox(width: AppDefaults.padding),
            SizedBox(
              width: 100,
              height: 100,
              child: ClipOval(
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    // child: Image.file(File(imagePath)),
                    child: NetworkImageWithLoader(currentUser!
                            .imageProfile.url.isEmpty
                        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                        : Uri.parse(currentUser!.imageProfile.url).toString())),
              ),
            ),
            const SizedBox(width: AppDefaults.padding),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentUser?.names} ${currentUser?.lastNames}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 2,
                    softWrap: true,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tipo: ${currentUser?.role.description}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
