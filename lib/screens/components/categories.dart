import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/models/api_response.dart';
import 'package:shopping_app/screens/components/product_card.dart';
import 'package:shopping_app/screens/components/section_title.dart';
import 'package:shopping_app/screens/details/details_screen.dart';
import 'package:shopping_app/services/category_services.dart';
import 'package:shopping_app/services/products_services.dart';
import 'package:shopping_app/services/user_services.dart';

import '../../constant.dart';
import '../login.dart';

class Categories extends StatefulWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;
  List<dynamic> _productsList = [];

  // Get comments
  Future<void> _getComments(id) async {
    ApiResponse response = await getProducts(id ?? 1);

    if (response.error == null) {
      setState(() {
        _productsList = response.data as List<dynamic>;
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

  Future<void> retrieveCategories() async {
    ApiResponse response = await getCategoies();

    if (response.error == null) {
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    retrieveCategories();
    _getComments(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 84,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _postList.length,
            itemBuilder: (context, index) => CategoryCard(
              icon: _postList[index].icon,
              title: _postList[index].title,
              press: () {
                _getComments(_postList[index].id);
              },
            ),
            separatorBuilder: (context, index) =>
                const SizedBox(width: defaultPadding),
          ),
        ),
        Column(
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
        )
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String icon, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2, horizontal: defaultPadding / 4),
        child: Column(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(height: defaultPadding / 2),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
