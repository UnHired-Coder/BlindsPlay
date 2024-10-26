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
          NavigationRail(
            backgroundColor: AppColors.primary,
            extended: true,
            minWidth: 300,
            selectedIndex: selectedIndex,
            onDestinationSelected: onTabSelected,
            useIndicator: false,
            labelType: NavigationRailLabelType.none,
            destinations: pageNavDestinations.asMap().entries.map((entry) {
              int idx = entry.key;
              PageNavModel pageModel = entry.value; // Use PageModel
              return NavigationRailDestination(
                icon: CustomNavItemUi(
                  isSelected: selectedIndex == idx,
                  label: pageModel.title, // Access title from PageModel
                  imageUrl: pageModel.icon, // Access icon from PageModel
                ),
                label: const SizedBox.shrink(),
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
