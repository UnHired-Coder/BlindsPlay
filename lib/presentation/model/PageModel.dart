import 'package:flutter/cupertino.dart';

class PageNavModel {
  final String title;
  final String icon;
  final Widget page;

  const PageNavModel({
    required this.title,
    required this.icon,
    required this.page,
  });
}
