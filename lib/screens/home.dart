import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/Product.dart';
import 'package:shopping_app/screens/breakout.dart';
import 'package:shopping_app/screens/drawer.dart';
import 'package:shopping_app/screens/favorits.dart';
import 'package:shopping_app/screens/profile.dart';
import 'package:shopping_app/screens/shopping_cart.dart';

import '../constant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  int _selectedIndex = 0;

  var _pages = <Widget>[Breakout(), ShoppingCard(), Favorit(), Profile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Product>(context).createPrefObject();
    Provider.of<Product>(context).loadItemsFromSharedPref();
    Provider.of<Product>(context).loadItemsFavoriteFromSharedPref();
    return Stack(
      children: [
        DrawerScreen(),
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          duration: Duration(milliseconds: 250),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: bgColor,
              primarySwatch: Colors.blue,
              fontFamily: "Gordita",
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              textTheme: const TextTheme(
                bodyText2: TextStyle(color: Colors.black54),
              ),
            ),
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: bgColor,
                leading: isDrawerOpen
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isDrawerOpen = false;
                          });
                        },
                        icon: SvgPicture.asset("assets/icons/menu.svg"),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            xOffset = 260;
                            yOffset = 80;
                            scaleFactor = 0.8;
                            isDrawerOpen = true;
                          });
                        },
                        icon: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/Location.svg"),
                    const SizedBox(width: defaultPadding / 2),
                    Text(
                      "15/2 Texas",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/Notification.svg"),
                    onPressed: () {},
                  ),
                ],
              ),
              body: _pages.elementAt(_selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: bgColor,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.home_filled),
                      icon: Icon(Icons.home_outlined),
                      title: Padding(padding: EdgeInsets.all(0))),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.shopping_cart),
                      icon: Icon(Icons.shopping_cart_outlined),
                      title: Padding(padding: EdgeInsets.all(0))),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.favorite),
                      icon: Icon(Icons.favorite_outline_sharp),
                      backgroundColor: Colors.red,
                      title: Padding(padding: EdgeInsets.all(0))),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.person),
                      icon: Icon(Icons.perm_identity),
                      title: Padding(padding: EdgeInsets.all(0))),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
