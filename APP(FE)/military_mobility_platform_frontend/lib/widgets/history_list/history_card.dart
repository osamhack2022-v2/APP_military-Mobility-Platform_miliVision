import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:military_mobility_platform_frontend/model/mileage.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(this.history, {super.key});
  final HistoryDTO history;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3.0,
        child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: SizedBox(
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateTimeSection(),
                    _buildLocationSection(),
                    _buildTimeSection(),
                    _buildRangeSection(),
                  ],
                ))));
  }

  Widget _buildDateTimeSection() {
    final datetime =
        DateFormat('`yy.MM.dd (E)', 'ko_KR').format(history.datetime);
    return Text(datetime);
  }

  Widget _buildLocationSection() {
    final summary =
        "출발지: ${history.departure}  🡆  목적지: ${history.destination}";
    return Text(summary);
  }

  Widget _buildTimeSection() {
    final timeSec = (history.totalTime % 60).toString().padLeft(2, '0');
    final timeMin =
        ((history.totalTime / 60).floor() % 60).toString().padLeft(2, '0');
    final timeHour =
        (history.totalTime / 3600).floor().toString().padLeft(2, '0');
    final time = "운행시간: $timeHour:$timeMin:$timeSec";
    return Text(time);
  }

  Widget _buildRangeSection() {
    final rangeKm = history.totalRange / 1000.0;
    final formatter = NumberFormat('###0.00');
    final range = "운행거리: ${formatter.format(rangeKm)}KM";
    return Text(range);
  }
}
