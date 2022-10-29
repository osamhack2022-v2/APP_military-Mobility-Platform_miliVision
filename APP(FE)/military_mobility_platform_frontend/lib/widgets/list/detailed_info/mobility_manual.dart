import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/service/mobility_assets.dart';

class MobilityManual extends StatelessWidget {
  const MobilityManual(this.mobility, {super.key});

  final MobilityDTO mobility;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
        future: MobilityAssets.getMobilityManual(mobility.type),
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
            return Markdown(
                data: snapshot.data!,
                styleSheet: MarkdownStyleSheet(
                    h1: GoogleFonts.roboto(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor),
                    h2: GoogleFonts.roboto(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor),
                    p: GoogleFonts.roboto(
                      fontSize: 17.0,
                      color: Colors.black,
                    )));
          }
        });
  }
}
