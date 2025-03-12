import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';


class PaysValuesRow extends StatefulWidget {
  const PaysValuesRow({
    super.key,
    required this.serviceFee,
    required this.hourleyRate,
    // required this.quantity,
  });

  final double serviceFee;
  final double hourleyRate;
  // final int quantity;

  @override
  State<PaysValuesRow> createState() => _PaysValuesRowState();
}

class _PaysValuesRowState extends State<PaysValuesRow> {
  int quantity = 1;

  // onQuantityIncrease() {
  //   quantity++;
  //   setState(() {});
  // }

  // onQuantityDecrease() {
  //   if (quantity > 1) {
  //     quantity--;
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // quantity = widget.quantity;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(

      children: [
        /* <---- Price -----> */
        SizedBox(
          width: size.width,
          child: Row(
            children: [
              Text(
                'Pago por servicio: ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text('\$${widget.serviceFee}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(height: AppDefaults.padding),
        SizedBox(
          width: size.width,
          child: Row(
            children: [
              Text(
                'Pago por hora: ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

              ),
              Text('\$${widget.hourleyRate}', 
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
