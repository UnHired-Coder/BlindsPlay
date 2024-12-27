import 'package:blindsplay/presentation/screens/tabs/tabs.dart';
import 'package:flutter/material.dart';

import '../../../../config/colors.dart';
import '../../../model/PageModel.dart';
import '../../../ui/widgets/customer_nav_item_ui.dart';

class WebLayout extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final List<Widget> tabs; // Assuming _pages is a list of widgets

  const WebLayout(
      {Key? key,
      required this.selectedIndex,
      required this.onTabSelected,
      required this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pageNavDestinations.asMap().entries.map((entry) {
              int idx = entry.key;
              PageNavModel pageModel = entry.value; // Use PageModel
              return GestureDetector(
                onTap: () => onTabSelected(idx), // Handle tab selection
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8), // Adjust spacing between items
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: selectedIndex == idx
                        ? AppColors.primary
                        : Colors.transparent, // Highlight selected item
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomNavItemUi(
                    isSelected: selectedIndex == idx,
                    label: pageModel.title, // Access title from PageModel
                    imageUrl: pageModel.icon,
                    highlightedIndex: idx == 0, // Access icon from PageModel
                  ),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: tabs,
            ),
          ),
        ],
      ),
    );
  }
}
