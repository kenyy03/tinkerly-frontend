import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/components/app_back_button.dart';
import 'package:mobile_frontend/src/features/profilemenu/screens/directions/bloc/address_bloc.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';
import 'package:quickalert/quickalert.dart';

class DirectionsView extends StatelessWidget {
  DirectionsView({super.key, required this.currentUserId});
  final String currentUserId;

  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _directionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void saveDirection(Address address) {
      if(address.city.id.isEmpty){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Es obligatorio seleccionar una Ciudad'
        );
        return;
      }

      if(address.directions.isEmpty){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Es obligatorio llenar las indicaciones de la dirección'
        );
        return;
      }
      context.read<AddressBloc>().add(SaveAddress(address: address));
    } 

    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(),
          title: Text('Dirección')),
      backgroundColor: AppColors.cardColor,
      body: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {
          if(state is AddressFailure){
            _directionsController.clear();
            _neighborhoodController.clear();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: state.messageError
            );
          }
          if(state is AddressUpdated){
            context.read<AddressBloc>().add(GetAddressByUserId(userId: currentUserId));
          }
          if(state is AddressObtained){
              _directionsController.text = state.address.directions;
              _neighborhoodController.text = state.address.neighborhood;
          }
        },
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.all(AppDefaults.margin),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding,
                        vertical: AppDefaults.padding * 2,
                      ),
                      child: Text(
                        'Actualiza tus datos\n de dirección',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(AppDefaults.margin),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding,
                        vertical: AppDefaults.padding * 2),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      boxShadow: AppDefaults.boxShadow,
                      borderRadius: AppDefaults.borderRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Ciudad"),
                        const SizedBox(height: 8),
                        TypeAheadField<City>(
                          itemBuilder: (context, value) {
                            return ListTile(
                              title: Text(value.description),
                            );
                          },
                          builder: (context, controller, focusNode) {
                            Future.delayed(Duration(milliseconds: 150), (){
                              controller.text = state.address.city.description;
                            });
                            return TextFormField(
                              enabled: state is! AddressLoading,
                              validator: Validators.requiredWithFieldName('City').call,
                              textInputAction: TextInputAction.next,
                              controller: controller,
                              focusNode: focusNode,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).nextFocus();
                              },
                            );
                          },
                          onSelected: (value) {
                            context.read<AddressBloc>().add(CityOnChanged(city: value));
                          },
                          suggestionsCallback: (search) {
                            final citiesCopy = [...state.cities];
                            return [...citiesCopy.where((city) => city.description.toLowerCase().contains(search.toLowerCase()))];
                          },
                        ),
                        const SizedBox(height: AppDefaults.padding),
                        const Text("Barrio / Colonia / Sector"),
                        const SizedBox(height: 8),
                        TextFormField(
                          enabled: (state is! AddressLoading),
                          validator:
                              Validators.requiredWithFieldName('Neighborhood')
                                  .call,
                          textInputAction: TextInputAction.next,
                          controller: _neighborhoodController,
                          onChanged: (value) {
                            context.read<AddressBloc>().add(
                                NeighborhoodOnChanged(neighborhood: value));
                          },
                        ),
                        const SizedBox(height: AppDefaults.padding),
                        const Text(
                            "Referencias / Indicaciones de la direccion"),
                        const SizedBox(height: 8),
                        TextFormField(
                          enabled: state is! AddressLoading ,
                          maxLines: 2,
                          enableSuggestions: false,
                          textInputAction: TextInputAction.done,
                          validator:
                              Validators.requiredWithFieldName('Directions')
                                  .call,
                          controller: _directionsController,
                          onChanged: (value) {
                            context
                                .read<AddressBloc>()
                                .add(DirectionsOnChanged(directions: value));
                          },
                          onFieldSubmitted: (_) => saveDirection(state.address),
                        ),
                        const SizedBox(height: AppDefaults.padding * 4),
                        state is! AddressLoading ?
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () => saveDirection(state.address),
                            child: Text('Guardar Dirección'),
                            // icon: Icon(Icons.save),
                          ),
                        ) : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.message),
                                CircularProgressIndicator()
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
            );
          },
        ),
      ),
    );
  }
}
