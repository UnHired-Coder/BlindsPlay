import 'package:blindsplay/config/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../config/colors.dart';
import '../../config/text_styles.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> pages;
  final Function(int, BuildContext) navigateToPage;

  HomePage({required this.pages, required this.navigateToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe', style: AppTextStyles.heading1),
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Add padding if needed
          child: Image.asset(
            "assets/favicon.png",
            width: 40,
            height: 30,
          ),
        ),
        centerTitle: !kIsWeb, // Center on mobile, start-aligned on web
      ),
      body: kIsWeb ? _buildWebLayout(context) : _buildMobileLayout(context),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (int index) {
            navigateToPage(index, context); // Navigation handling
          },
          labelType: NavigationRailLabelType.selected,
          destinations: pages
              .map((page) => NavigationRailDestination(
            icon: Icon(page['icon']),
            label: Text(page['title']),
          ))
              .toList(),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Select a page from the side navigation bar',
              style: AppTextStyles.heading3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(40.0),
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
            onPressed: () {
              navigateToPage(index, context); // Navigate to the selected page
            },
            style: secondaryButtonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(pages[index]['icon']),
                const SizedBox(width: 10),
                Text(
                  pages[index]['title'],
                  style: AppTextStyles.button,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
