import 'package:firebase_login/Screens/HomeScreen/constraints.dart';
import 'package:firebase_login/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'file:///C:/Users/OWNER/AndroidStudioProjects/firebase_login/lib/Screens/HomeScreen/HomePageTab/product_detail_page.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: ProductDetailsPage(product: product,),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset('assets/icons/cart.svg'),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPadding / 2,),
      ],
    );
  }
}
