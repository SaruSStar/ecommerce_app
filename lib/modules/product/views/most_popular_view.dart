import 'package:ecommerce_app/modules/product/product_provider.dart';
import 'package:ecommerce_app/widgets/product_grid_card.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

class MostPopularView extends StatelessWidget {
  const MostPopularView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.items;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            child: Text(
              'Most Popular',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return ChangeNotifierProvider.value(
                  value: product,
                  child: const ProductGridCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
