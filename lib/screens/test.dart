import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
            color: Colors.white,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/product_3.png',
                  height: 132,
                ),
                Text(
                  'Heed not the rabble',
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  '\$14',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ],
            )),
      ],
    );
  }
}
