import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/src/features/professionalitem/components/professional_item_tile_square.dart';
import 'package:mobile_frontend/src/features/professionalitem/cubit/professional_cubit.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfessionalItemView extends StatelessWidget {
  const ProfessionalItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profesionales', textAlign: TextAlign.center),
          ],
        ),
      ),
      body: BlocBuilder<ProfessionalCubit, ProfessionalState >(
        builder: (context, state) {
          return state is ProfessionalsLoading 
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                SizedBox(height: AppDefaults.margin),
                CircularProgressIndicator(),
              ],
            ),
          ) 
          : GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: AppDefaults.padding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              childAspectRatio: 0.80,
            ),
            itemCount: state.usersPublic.length,
            itemBuilder: (context, index) {
              return ProfessionalItemTileSquare(
                data: state.usersPublic[index],
              );
            },
          );
        },
      ),
    );
  }
}
