import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constant.dart';
import 'package:shopping_app/models/Product.dart';
import 'package:shopping_app/screens/components/mycart.dart';

class ShoppingCard extends StatefulWidget {
  @override
  _ShoppingCardState createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, itemData, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              '${Provider.of<Product>(context).items.length} Items',
              style: TextStyle(color: Colors.red),
            ),
            centerTitle: true,
          ),
          backgroundColor: bgColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemData.items.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            onDismissed: (direction) {
                              itemData.deleteItem(index);
                            },
                            key: UniqueKey(),
                            child: MyCard(
                              title: '${itemData.items[index].title}',
                              image: '${itemData.items[index].image}',
                              price: '${itemData.items[index].price}',
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  // @override
  // void initState() {
  //   setState(() {
  //   });
  //   super.initState();
  // }
}
