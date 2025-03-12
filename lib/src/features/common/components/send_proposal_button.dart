import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';


class SendProposalButton extends StatelessWidget {
  const SendProposalButton({
    super.key,
    // required this.onCartButtonTap,
    required this.onSendProposalButtonTap,
  });

  // final void Function() onCartButtonTap;
  final void Function() onSendProposalButtonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDefaults.padding,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onSendProposalButtonTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppDefaults.padding * 1.2),
              ),
              child: const Text('Enviar Propuesta'),
            ),
          ),
        ],
      ),
    );
  }
}
