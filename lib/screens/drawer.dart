import 'package:flutter/material.dart';
import 'package:shopping_app/models/drawermodel.dart';
import 'package:shopping_app/screens/auth.dart';
import 'package:shopping_app/services/user_services.dart';

import '../constant.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Container(
        color: bgColor,
        padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nizami Alizadeh',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.none),
                    ),
                    Text('Active Status',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            decoration: TextDecoration.none))
                  ],
                )
              ],
            ),
            Column(
              children: drawerItems
                  .map((element) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              color: Color(0xFFF1F8E9),
                              child: Icon(
                                element['icon'],
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(element['title'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: TextDecoration.none))
                          ],
                        ),
                      ))
                  .toList(),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  color: Color(0xFFF1F8E9),
                  child: Icon(
                    Icons.login_outlined,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    logout().then((value) => {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Auth()),
                              (route) => false)
                        });
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        decoration: TextDecoration.none),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
