import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/category_info..dart';

class CategoryChips extends StatefulWidget {
  final ValueChanged<Category> onCategorySelected;

  CategoryChips({@required this.onCategorySelected});

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3.0,
      children: List<Widget>.generate(categories.length, (int i) {
        return ChoiceChip(
          label: Text(categories[i].nameJp),
          selected: _currentIndex == i,
          onSelected: (bool isSelected) {
            setState(() {
              _currentIndex = isSelected ? i : 0;
              widget.onCategorySelected(categories[i]);
            });
          },
        );
      }).toList(),
    );
  }
}
