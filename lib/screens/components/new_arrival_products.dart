import 'package:flutter/material.dart';
import 'package:shopping_app/models/api_response.dart';
import 'package:shopping_app/screens/details/details_screen.dart';
import 'package:shopping_app/screens/login.dart';
import 'package:shopping_app/services/products_services.dart';
import 'package:shopping_app/services/user_services.dart';

import '../../constant.dart';
import 'product_card.dart';
import 'section_title.dart';

class NewArrivalProducts extends StatefulWidget {
  const NewArrivalProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<NewArrivalProducts> createState() => _NewArrivalProductsState();
}

class _NewArrivalProductsState extends State<NewArrivalProducts> {
  List<dynamic> _productsList = [];
  bool _loading = true;

  // Get comments
  Future<void> _getComments() async {
    ApiResponse response = await getProducts(1);

    if (response.error == null) {
      setState(() {
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    _getComments();
    super.initState();
  }

  Widget build(BuildContext context) {
    // int? ad = Provider.of<Category>(context).idss;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: SectionTitle(
            title: "New Arrival",
            pressSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              _productsList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  title: _productsList[index].title,
                  image: _productsList[index].image,
                  price: _productsList[index].price,
                  // bgColor: _commentsList[index].bgColor,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(product: _productsList[index]),
                        ));
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
