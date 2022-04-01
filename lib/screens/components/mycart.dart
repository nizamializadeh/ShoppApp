import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class MyCard extends StatelessWidget {
  String image;
  String title;
  String price;
  MyCard({required this.image, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(defaultBorderRadius)),
                    ),
                    child: Image.asset(
                      image,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "\$" + price,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SizedBox(
                        width: 32.0,
                        height: 22.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Text(
                      '0',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: SizedBox(
                        width: 30.0,
                        height: 20.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            '-',
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
