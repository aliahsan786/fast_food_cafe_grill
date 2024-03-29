import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Widget/MenuTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoiteScreen extends StatelessWidget {
  const FavoiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<MenusProvider>(context).favoriteItem();
    final listItem =
        Provider.of<MenusProvider>(context, listen: false).favoriteList;
    final cafe = Provider.of<Cafe>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 45.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: listItem.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: listItem[i],
            child: cafe.isSelected == '' ? Container() : MenuTile(),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.4 / 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
        ),
      ),
    );
  }
}
