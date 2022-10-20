import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:military_mobility_platform_frontend/constatns/tabs.dart';
import 'package:military_mobility_platform_frontend/model/tab.dart';

class NavigationProvider extends ChangeNotifier {
  final PageController _pageController = PageController();
  int _currentTabIdx = 0;
  int _currentNavBarItemIdx = 0;

  PageController get pageController => _pageController;
  int get currentNavBarItemIdx => _currentNavBarItemIdx;
  TabVO get currentTab => kTabs[_currentTabIdx];

  List<Widget> get tabWidgets => kTabs.map((e) => e.builder()).toList();

  List<TabVO> get navBarItemTabs =>
      kTabs.where((element) => element.navBarItem != null).toList();

  List<BottomNavigationBarItem> get navigationBarOptions => navBarItemTabs
      .asMap()
      .entries
      .map((entry) => BottomNavigationBarItem(
          icon: Text(entry.value.navBarItem!.label,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: entry.key == _currentNavBarItemIdx
                      ? Colors.white
                      : Colors.white60)),
          label: ''))
      .toList();

  AppBar buildCurrentTabAppBar(BuildContext context) => AppBar(
      leading: currentTab.appbar.leading != null
          ? currentTab.appbar.leading!(context)
          : kDefaultAppBarLeading,
      title: Text(currentTab.appbar.title));

  void animateToTabWithNavBarIdx(int idx, {Duration? duration, Curve? curve}) {
    final navBarItemTabs = this.navBarItemTabs;
    if (idx < 0 || idx >= navBarItemTabs.length) throw "idx out of range";
    animateToTabWithName(navBarItemTabs[idx].name,
        duration: duration, curve: curve);
  }

  void animateToTabWithName(String tabName,
      {Duration? duration, Curve? curve}) {
    var tabIdx = kTabs.indexWhere((element) => element.name == tabName);
    if (tabIdx < 0) throw "cannot find tab to change";
    _currentTabIdx = tabIdx;
    final navBarItemIdx =
        navBarItemTabs.indexWhere((element) => element.name == tabName);
    _currentNavBarItemIdx =
        navBarItemIdx < 0 ? _currentNavBarItemIdx : navBarItemIdx;

    _pageController.animateToPage(_currentTabIdx,
        duration: duration ?? const Duration(milliseconds: 250),
        curve: curve ?? Curves.ease);
    notifyListeners();
  }
}
