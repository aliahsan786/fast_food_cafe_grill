// ignore_for_file: prefer_final_fields, file_names
import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Widget/MenuWithType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var _isLoading = false;

  Future<void> refreshMenu() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<MenusProvider>(context, listen: false)
        .fetchAndSetProduct();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cafe = Provider.of<Cafe>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshMenu,
          child: _isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : cafe.isSelected == ''
                  ? const Center(
                      child: Text(
                          'Please select any cafe from the home screen to view the data'),
                    )
                  : SingleChildScrollView(
                      // ignore: sized_box_for_whitespace
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          //.......................................................................................//////.....
                          const MenuWithType('Everyday Value'),
                          const MenuWithType('Make it a Meal'),
                          const MenuWithType('Signature Box'),
                          const MenuWithType('Sharing'),
                          const MenuWithType('Mid Night Deals'),
                          const MenuWithType('Snacks'),

                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
