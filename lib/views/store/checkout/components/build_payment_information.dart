import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/museum_information.dart';
import 'package:museo/models/store/payments_methods.dart';

class BuildPaymentInformation extends StatelessWidget {
  final MuseumInformation museumInformation;

  const BuildPaymentInformation({
    super.key,
    required this.museumInformation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: context.loc.accept_payments_in,
              style: DefaultTextStyle.of(context).style,
              children: fakeExtraPaymentMethods.map((element) {
                if (element == fakeExtraPaymentMethods.last) {
                  return TextSpan(
                    text: ' e ',
                    children: [
                      TextSpan(
                        text: element.text.toUpperCase(),
                        style: const TextStyle(
                          color: mainBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                } else {
                  return TextSpan(
                    text: element == fakeExtraPaymentMethods.first ? '' : ', ',
                    children: [
                      TextSpan(
                        text: element.text.toUpperCase(),
                        style: const TextStyle(
                          color: mainBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
              }).toList(),
            ),
            textAlign: TextAlign.justify,
          ),
          const Text(
            'NÃO ACEITAMOS PIX',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Para mais informações, entrar em contato por \nE-mail: ${museumInformation.emailList[0].email} \nTelefone: ${museumInformation.phoneList[0].phoneNumber}',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
