import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/Product.dart';

class Favorit extends StatefulWidget {
  @override
  _FavoritState createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, itemData, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              'Favorites',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white54,
          body: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: List.generate(itemData.itemsFavorite.length, (index) {
              return Center(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          itemData.deleteFavoriteItem(index);
                        },
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 0),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Image.asset(
                              '${itemData.itemsFavorite[index].image}',
                              height: 132,
                            ),
                            Text(
                              '${itemData.itemsFavorite[index].title}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              ' \$${itemData.itemsFavorite[index].price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                            ),
                          ],
                        )),
                  ],
                ),
              );
            }),
          )),
    );
  }
}
