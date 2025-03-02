import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/common/components/network_image.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class AdSpace extends StatelessWidget {
  const AdSpace({
    super.key,
    this.title='',
    this.imageUrl = ''
  });

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppDefaults.borderRadius,
          color: AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: AppDefaults.margin * 1.5),
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                        color: AppColors.scaffoldBackground,
                        fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .55,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: NetworkImageWithLoader(
                  imageUrl,
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}