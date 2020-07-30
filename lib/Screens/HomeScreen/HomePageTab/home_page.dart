import 'package:firebase_login/Screens/HomeScreen/constraints.dart';
import 'file:///C:/Users/OWNER/AndroidStudioProjects/firebase_login/lib/Screens/HomeScreen/HomePageTab/details_screen.dart';
import 'file:///C:/Users/OWNER/AndroidStudioProjects/firebase_login/lib/Screens/HomeScreen/HomePageTab/item_card.dart';
import 'package:firebase_login/models/Product.dart';
import 'package:flutter/material.dart';

import 'categories.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: Text(
            "Products",
            style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPadding,
                crossAxisSpacing: kDefaultPadding,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                product: products[index],
                press: () => Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    product: products[index],
                  )
                )
                ),
              )
            ),
          ),
        )
      ],
    );
  }
}
