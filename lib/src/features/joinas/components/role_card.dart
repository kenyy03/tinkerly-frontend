import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/common/components/app_radio.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key, 
    this.onTap, 
    this.labelText,  
    this.isActive = false,
    this.isFirstElement = false,
  });

  final VoidCallback? onTap;
  final String? labelText;
  final bool isActive;
  final bool isFirstElement;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .40,
        height: MediaQuery.of(context).size.height * .18,
        padding: EdgeInsets.all(AppDefaults.padding),
        margin: EdgeInsets.only(right: isFirstElement ? AppDefaults.margin : 0),
        decoration: BoxDecoration(
          borderRadius: AppDefaults.borderRadius,
          border: Border.all()
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.business_center, color: Theme.of(context).colorScheme.primary),
                AppRadio(isActive: isActive),
              ],
            ),
            SizedBox(height: AppDefaults.padding),
            Text(
              labelText ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
      ),
    );
  }
}