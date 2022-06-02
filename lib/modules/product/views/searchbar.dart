import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/modules/filter/full_screen_search.dart';
import 'package:ecommerce_app/modules/product/product_provider.dart';
import 'package:ecommerce_app/modules/product/views/single_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searchbar extends StatefulWidget {
  final void Function()? onButtonTap;
  final TextEditingController? controller;
  final Widget? customSuffixIcon;
  final bool autoFocus;
  const Searchbar({
    Key? key,
    this.onButtonTap,
    this.controller,
    this.customSuffixIcon,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0),
      child: TextFormField(
        readOnly: true,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          hintText: 'Search Your Model',
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
            ),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                16,
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: widget.customSuffixIcon ??
                IconButton(
                  onPressed: widget.onButtonTap,
                  icon: Icon(
                    CupertinoIcons.search,
                    color: Theme.of(context).cardColor,
                  ),
                ),
          ),
        ),
        onTap: () async {
          final products =
              Provider.of<ProductProvider>(context, listen: false).items;
          final res = await showSearch(
            context: context,
            delegate: FullScreenSearch<Product?>(
              searchList: products,
              overlaySearchListItemBuilder: (Product? product) {
                return ListTile(
                  title: Text(product?.name ?? ''),
                  trailing: const Icon(Icons.arrow_right_alt_rounded),
                );
              },
              searchQueryBuilder: (String query, List<Product?> list) {
                final listItems = list
                    .where(
                      (item) => item!.name!.toLowerCase().contains(
                            query.toLowerCase(),
                          ),
                    )
                    .toList();
                return listItems;
              },
            ),
          );
          final product = res as Product?;
          if (!mounted || product == null) return;
          Navigator.pushNamed(context, SinglePageView.routeName,
              arguments: product);
        },
      ),
    );
  }
}
