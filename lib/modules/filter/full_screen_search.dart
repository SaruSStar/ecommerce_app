import 'package:flutter/material.dart';

class FullScreenSearch<T> extends SearchDelegate {
  final List<T> searchList;
  Widget Function(T) overlaySearchListItemBuilder;
  List<T> Function(String, List<T>) searchQueryBuilder;
  Widget? noItemsFoundWidget;
  void Function(T)? onItemSelected;
  bool dividerActive;
  FullScreenSearch({
    required this.searchList,
    required this.overlaySearchListItemBuilder,
    required this.searchQueryBuilder,
    this.noItemsFoundWidget,

    ///  onItem selected is not required
    ///  Still FullScreenSearch is a future bu default it will return selected type of your list
    ///  List<T> will return T
    this.onItemSelected,
    this.dividerActive = false,
  });

  List<T> suggestionList = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super
              .appBarTheme(context)
              .appBarTheme
              .copyWith(toolbarHeight: 66),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList =
        query.isEmpty ? searchList : searchQueryBuilder(query, searchList);
    if (suggestionList.isEmpty) {
      return noItemsFoundWidget ?? const SizedBox.shrink();
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      itemCount: suggestionList.length,
      separatorBuilder: (context, index) =>
          dividerActive ? const Divider(height: 8) : const SizedBox.shrink(),
      itemBuilder: (context, index) {
        final T item = suggestionList[index];
        return overlaySearchListItem(context, item);
      },
    );
  }

  GestureDetector overlaySearchListItem(
    BuildContext context,
    T item,
  ) {
    return GestureDetector(
      onTap: () {
        if (onItemSelected != null) {
          onItemSelected!(item);
        } else {
          close(context, item);
        }
      },
      child: overlaySearchListItemBuilder(item),
    );
  }

  Widget getHighligtText(BuildContext context, String text, String query) {
    int queryIndex = text.toLowerCase().indexOf(query.toLowerCase());
    return RichText(
      text: TextSpan(
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color:
                  Theme.of(context).textTheme.bodyText1?.color?.withAlpha(180),
              fontSize: 18),
          text: text.substring(0, queryIndex),
          children: [
            TextSpan(
              text: text.substring(queryIndex, queryIndex + query.length),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: text.substring(queryIndex + query.length),
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.color
                      ?.withAlpha(180),
                  fontWeight: FontWeight.w500),
            )
          ]),
    );
  }
}
