import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class CustomChoiceChipList extends StatelessWidget {
  const CustomChoiceChipList({super.key, 
    required this.data,
    this.isWrap = false,
    this.itemCount = 3,
  });

  final UserPublic data;
  final bool isWrap;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    var list = List.generate(
        itemCount,
        (index) {
          return Container(
            margin: EdgeInsets.only(right: AppDefaults.margin),
            child: ChoiceChip(
              label: Text(
                data.userAbilities[index].ability.description, 
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold
                )
              ), 
              selected: false
            ),
          );
        }, 
      );
    return !isWrap ? Row(
      children: list
    ) : Wrap(
      children: list,
    ) ;
  }
}