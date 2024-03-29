import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Screens/CafeUpdateScreen.dart';
import 'package:fast_food_cafe_grill/Screens/Location_Map.dart';
import 'package:fast_food_cafe_grill/Screens/MenuUpdateScreen.dart';
import 'package:fast_food_cafe_grill/Screens/NumberAuth.dart';
import 'package:fast_food_cafe_grill/Screens/OrderScreen.dart';
import 'package:fast_food_cafe_grill/Screens/ContactUs.dart';
import 'package:fast_food_cafe_grill/Screens/PrivacyPolicy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final loc = Provider.of<Auth>(context, listen: false).placemarks![0];
    const textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'More',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white70,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            InkWell(
              child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(
                    // auth.locationPoint == null
                    //     ?
                    'Store Location',
                    // : '${loc.country},${loc.administrativeArea},${loc.locality},${loc.street}',
                    style: textStyle,
                  ),
                  trailing: Icon(Icons.navigate_next)),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LocationMap()));
              },
            ),
            const Divider(
              height: 1,
            ),
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  'Contact us',
                  style: textStyle,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ContactUS()));
              },
            ),
            const Divider(
              height: 1,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  auth.phone == null ? 'add Number' : auth.phone.toString(),
                  style: textStyle,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NumberAuth()));
              },
            ),
            const Divider(
              height: 1,
            ),
            // const ListTile(
            //   title: Text(
            //     'About Us',
            //     style: textStyle,
            //   ),
            // ),
            // const Divider(
            //   height: 1,
            // ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy()));
              },
              child: const ListTile(
                title: Text(
                  'Privacy Policy',
                  style: textStyle,
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),

            auth.isAuth
                ? InkWell(
                    onTap: () {
                      auth.logout();
                    },
                    child: const ListTile(
                        title: Text(
                          'Logout',
                          style: textStyle,
                        ),
                        trailing: Icon(Icons.logout)),
                  )
                : InkWell(
                    onTap: () {},
                    child: const ListTile(
                      title: Text(
                        'Get login',
                        style: textStyle,
                      ),
                      trailing: Icon(Icons.login),
                    ),
                  ),
            const Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
