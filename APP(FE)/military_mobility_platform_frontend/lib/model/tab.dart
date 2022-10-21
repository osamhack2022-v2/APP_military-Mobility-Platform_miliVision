import 'package:flutter/material.dart';

class NavBarItemVO {
  const NavBarItemVO({required this.label});
  final String label;
}

class AppBarVO {
  const AppBarVO({required this.title, this.leading, this.actions});
  final String title;
  final Widget Function(BuildContext)? leading;
  final List<Widget> Function(BuildContext)? actions;
}

class TabVO {
  const TabVO(
      {required this.name,
      required this.builder,
      required this.appbar,
      this.navBarItem,
      this.floatingButton});
  final String name;
  final Widget Function() builder;
  final AppBarVO appbar;
  final NavBarItemVO? navBarItem;
  final Widget? Function(BuildContext)? floatingButton;
}
