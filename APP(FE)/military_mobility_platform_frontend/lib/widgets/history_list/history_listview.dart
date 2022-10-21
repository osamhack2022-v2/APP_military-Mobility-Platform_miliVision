import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:military_mobility_platform_frontend/provider/driving_history.dart';
import 'package:military_mobility_platform_frontend/widgets/history_list/history_card.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListProvider = Provider.of<DrivingHistoryProvider>(context);
    final histories = historyListProvider.histories;
    final totalRange = histories.fold(0, (sum, elem) => sum + elem.totalRange);
    final rangeKm = totalRange / 1000.0;
    final formatter = NumberFormat('###0.00');
    final textStyle =
        GoogleFonts.roboto(fontSize: 21.0, fontWeight: FontWeight.bold);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                  height: 60.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('운행내역', style: textStyle),
                        Text("누적KM ${formatter.format(rangeKm)}KM",
                            style: textStyle)
                      ]))),
          Expanded(
              child: ListView.builder(
            itemCount: histories.length,
            itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 17.0),
                child: HistoryCard(histories[index])),
          ))
        ]));
  }
}
