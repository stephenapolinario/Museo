import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';
import 'package:provider/provider.dart';

class BuildTotalAndPayment extends StatelessWidget {
  const BuildTotalAndPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ShoppingTicketCart providerTicket =
        context.watch<ShoppingTicketCart>();
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: mainBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${context.loc.current_cart}: ${generatePrice(price: providerTicket.cart.totalPriceBeforeDiscount)}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            // TODO:  Payment screen
            checkoutButton(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton checkoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(
            color: mainGray,
          ),
        ),
        backgroundColor: Colors.green.shade500,
        foregroundColor: mainBlue,
      ),
      onPressed: () {
        if (Provider.of<ShoppingTicketCart>(context, listen: false)
            .anyTicket()) {
          Navigator.of(context).pushNamed(checkout);
        } else {
          showGenericDialog(
            context: context,
            title: context.loc.dialog_error_ops,
            content: context.loc.first_select_tickets,
            optionsBuilder: () => {
              'Ok': false,
            },
          );
        }
        return;
      },
      child: Text(
        context.loc.checkout,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
