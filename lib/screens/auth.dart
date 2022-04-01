import 'package:flutter/material.dart';
import 'package:shopping_app/screens/register.dart';

import 'login.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Instagram',
            style: TextStyle(color: Colors.black),
          ),
          bottom: const TabBar(
            indicatorWeight: 1,
            tabs: <Widget>[
              Tab(
                text: 'Login',
              ),
              Tab(
                text: 'Register',
              ),
            ],
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Login(),
            Register(),
          ],
        ),
      ),
    );
  }
}
