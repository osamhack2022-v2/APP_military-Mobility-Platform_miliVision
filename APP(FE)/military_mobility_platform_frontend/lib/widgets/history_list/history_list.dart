import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/driving_history.dart';
import 'package:military_mobility_platform_frontend/widgets/history_list/history_listview.dart';
import 'package:provider/provider.dart';

class HistoryListTab extends StatelessWidget {
  const HistoryListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListProvider =
        Provider.of<DrivingHistoryProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final authClient = authProvider.authenticatedClient!;
    return FutureBuilder(
        future: historyListProvider.getHistories(authClient),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                  Icon(Icons.error, size: 50.0),
                  Text('로딩 중 에러가 발생했습니다.')
                ]));
          } else {
            return const Padding(
                padding: EdgeInsets.only(top: 11.0), child: HistoryListView());
          }
        });
  }
}
