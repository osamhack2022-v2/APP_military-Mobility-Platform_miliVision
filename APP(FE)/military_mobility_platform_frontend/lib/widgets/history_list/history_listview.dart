import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/provider/driving_history.dart';
import 'package:military_mobility_platform_frontend/widgets/history_list/history_card.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListProvider = Provider.of<DrivingHistoryProvider>(context);
    final histories = historyListProvider.histories;
    return ListView.builder(
      itemCount: histories.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 7.0),
          child: HistoryCard(histories[index])),
    );
  }
}
