import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/widgets/login/login.dart';
import 'package:provider/provider.dart';

class NavigatedHome extends StatefulWidget {
  const NavigatedHome({super.key});

  @override
  NavigatedHomeState createState() => NavigatedHomeState();
}

class NavigatedHomeState extends State<NavigatedHome> {
  @override
  void dispose() {
    Provider.of<NavigationProvider>(context).pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return authProvider.isLoggedIn
        ? Scaffold(
            appBar: navigationProvider.buildCurrentTabAppBar(context),
            drawer: _buildDrawer(context),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: navigationProvider.pageController,
              children: navigationProvider.tabWidgets,
            ),
            bottomNavigationBar: _buildNavigationBar(context),
            floatingActionButton:
                navigationProvider.currentTab.floatingButton != null
                    ? navigationProvider.currentTab.floatingButton!(context)
                    : null)
        : const Scaffold(body: LoginTab());
  }

  Widget _buildNavigationBar(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: navigationProvider.navigationBarOptions,
        currentIndex: navigationProvider.currentNavBarItemIdx,
        onTap: (index) => navigationProvider.animateToTabWithNavBarIdx(index),
        showSelectedLabels: false,
        showUnselectedLabels: false);
  }

  Widget _buildDrawer(BuildContext context) {
    //final userInfoProvider = Provider.of<UserInfoProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/userImage.png'),
            ),
            accountName: Text('사용자 이름', style: TextStyle(fontSize: 20.0)),
            accountEmail: Text('소속', style: TextStyle(fontSize: 14.0)),
            decoration: BoxDecoration(
                color: Color(0xFF6200EE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
          ),
          ListTile(
            title: Text('이용내역', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('내 정보 수정', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('공지사항', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('자주하는 질문', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('이용방법', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('사고센터 접수', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('앱 권한 설정', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('개인정보처리방침', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('로그아웃', style: TextStyle(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
