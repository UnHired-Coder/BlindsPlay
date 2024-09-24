import 'package:blindsplay/presentation/screens/pages.dart';
import 'package:flutter/material.dart';
import '../../../../config/colors.dart';
import '../../../../config/text_styles.dart';
import '../../../model/PageModel.dart';

class MobileLayout extends StatelessWidget {
  final ValueChanged<int> onTabSelected; // To handle tab selection
  final int selectedIndex; // To manage the currently selected index
  final List<Widget> pageWidgets; // List of page widgets

  const MobileLayout({
    Key? key,
    required this.onTabSelected,
    required this.selectedIndex,
    required this.pageWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(40.0),
              itemCount: pageNavDestinations.length,
              itemBuilder: (context, index) {
                PageNavModel pageModel = pageNavDestinations[index]; // Use PageModel
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Update the selected index
                      onTabSelected(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pageModel.page, // Access page from PageModel
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pageModel.title, // Access title from PageModel
                          style: AppTextStyles.button,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 10),
                        Image(
                          image: AssetImage(pageModel.icon), // Access icon from PageModel
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Optionally add a footer or any additional elements here
        ],
      ),
    );
  }
}
