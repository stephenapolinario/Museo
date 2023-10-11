import 'package:flutter/material.dart';
import 'package:museo/models/store/products.dart';
import 'package:museo/views/store/souvenirs/components/build_item_card.dart';
import 'package:museo/views/store/souvenirs/souvenirs_detail_view.dart';

class BuildGridProducts extends StatelessWidget {
  final int categorieIndex;

  const BuildGridProducts({
    super.key,
    required this.categorieIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
            itemCount: fakeSouvenirsList[categorieIndex].products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return BuildItemCard(
                product: fakeSouvenirsList[categorieIndex].products[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SouvenirsDetailsView(
                      product:
                          fakeSouvenirsList[categorieIndex].products[index],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}