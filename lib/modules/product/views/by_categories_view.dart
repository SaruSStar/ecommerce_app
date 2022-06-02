import 'package:ecommerce_app/constants/images.dart';
import 'package:ecommerce_app/modules/filter/filter_provider.dart';
import 'package:ecommerce_app/modules/filter/filter_view.dart';
import 'package:ecommerce_app/modules/product/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ByCategoriesView extends StatelessWidget {
  const ByCategoriesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          child: Text(
            'By Category',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 28.0),
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              children: categories.map((category) {
                final name = category?.name ?? '';
                final image = category?.image ?? '';
                final colour = category?.colour ?? Colors.white;
                return InkWell(
                  onTap: () {
                    filterProvider.fetchAndSetFilterItems(category: name);
                    Navigator.pushNamed(context, FilterView.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colour,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 36,
                          child: Image.asset(
                            image,
                            color: Theme.of(context).cardColor,
                            errorBuilder: (_, __, ___) =>
                                Image.asset(Images.placeHolder),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            name,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Theme.of(context).cardColor,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
