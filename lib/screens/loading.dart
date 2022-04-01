import 'package:flutter/material.dart';
import 'package:shopping_app/models/api_response.dart';
import 'package:shopping_app/services/user_services.dart';

import '../constant.dart';
import 'auth.dart';
import 'home.dart';
import 'login.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loaduserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Auth()), (route) => false);
    } else {
      ApiResponse response = await getUserDetail();
      print(response.error);

      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    _loaduserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
