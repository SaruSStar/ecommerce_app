import 'package:ecommerce_app/constants/images.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/modules/favorite/favorite_provider.dart';
import 'package:ecommerce_app/modules/product/views/single_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final id = product.id;
    final model = product.model ?? '';
    final image = product.image ?? '';
    final bgColor = product.bgColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: bgColor,
      ),
      margin: const EdgeInsets.only(right: 16),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          height: 150,
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model, style: Theme.of(context).textTheme.headline6),
                  Consumer<FavoriteProvider>(
                    builder: (context, favoriteProvider, child) => IconButton(
                      icon: Icon(
                        favoriteProvider.isFavorite(id)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: Theme.of(context).cardColor,
                      ),
                      iconSize: 32,
                      onPressed: () {
                        favoriteProvider.toggleFavorite(product);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SinglePageView.routeName,
                      arguments: product);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.placeHolder,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
