import 'network_image.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/professionaldetails/components/animated_dots.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfileImagesSlider extends StatefulWidget {
  const ProfileImagesSlider({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<ProfileImagesSlider> createState() => _ProfileImagesSliderState();
}

class _ProfileImagesSliderState extends State<ProfileImagesSlider> {
  late PageController controller;
  int currentIndex = 0;
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.images;
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: AppColors.coloredBackground,
        borderRadius: AppDefaults.borderRadius,
      ),
      height: MediaQuery.of(context).size.height * 0.43,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (v) {
                    currentIndex = v;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: NetworkImageWithLoader(
                          images[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  itemCount: images.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: AnimatedDots(
                  totalItems: images.length,
                  currentIndex: currentIndex,
                ),
              )
            ],
          ),
          // Positioned(
          //   right: 0,
          //   child: Material(
          //     color: Colors.transparent,
          //     borderRadius: AppDefaults.borderRadius,
          //     child: IconButton(
          //       onPressed: () {},
          //       iconSize: 56,
          //       constraints: const BoxConstraints(minHeight: 56, minWidth: 56),
          //       icon: Container(
          //         padding: const EdgeInsets.all(AppDefaults.padding),
          //         decoration: const BoxDecoration(
          //           color: AppColors.scaffoldBackground,
          //           shape: BoxShape.circle,
          //         ),
          //         child: SvgPicture.asset(AppIcons.heart),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
