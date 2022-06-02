import 'package:ecommerce_app/modules/filter/filter_provider.dart';
import 'package:ecommerce_app/widgets/product_grid_card.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterView extends StatefulWidget {
  static const String routeName = '/filter';
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    final items = filterProvider.filterItems;
    if (items.isEmpty) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.insert_emoticon_sharp,
                size: 56,
              ),
            ),
            Text('No items found'),
          ],
        ),
      );
    } else {
      return Theme(
        data: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(filterProvider.filterQuery ?? ''),
            centerTitle: true,
            backgroundColor: Theme.of(context).splashColor,
            elevation: 0,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(36),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final product = items[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChangeNotifierProvider.value(
                  value: product,
                  child: const ProductGridCard(),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
