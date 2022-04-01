import 'package:flutter/material.dart';
import 'package:shopping_app/screens/components/search_form.dart';

import '../constant.dart';
import 'components/categories.dart';

class Breakout extends StatefulWidget {
  @override
  _BreakoutState createState() => _BreakoutState();
}

class _BreakoutState extends State<Breakout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.all(defaultPadding),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "best Outfits for you",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: SearchForm(),
            ),
            Categories(),
            // PopularProducts(),
          ],
        ),
      ),
    );
  }
}
