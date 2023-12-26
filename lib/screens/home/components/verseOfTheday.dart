import 'dart:math';

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/helpers/helpers.dart';
import 'package:pocket_siddur/size_config.dart';

class VerseOfTheDayCard extends ConsumerStatefulWidget {
  @override
  _VerseOfTheDayCardState createState() => _VerseOfTheDayCardState();
}

class _VerseOfTheDayCardState extends ConsumerState<VerseOfTheDayCard> {
  List<String> _verses = Helper().bibleVerses;
  Random random = Random();
  var verse = "";
  @override
  Widget build(BuildContext context) {
    Color bgColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.gray[800]!;
      }
      return CantonColors.gray[300]!;
    }

    return Container(
      width: getProportionateScreenWidth(350),
      padding: EdgeInsets.all(
        getProportionateScreenHeight(15),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: CantonMethods.alternateCanvasColorType3(context),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context, bgColor()),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    _body(context, bgColor()),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    _bookChapterVerse(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, Color bgColor) {
    return Text(
      'Verse of the Day',
      style: TextStyle(
        color: primaryColor,
        fontSize: getProportionateScreenHeight(14),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _body(BuildContext context, Color bgColor) {
    String verseText() {
      String contentOfVerse = _verses[random.nextInt(
        _verses.length,
      )];
      List<String> parts = contentOfVerse.split('(');
      String reference = parts.length > 1 ? parts[1].replaceAll(')', '') : '';
      if (reference.isNotEmpty) {}
      setState(() {
        verse = reference;
      });

      return parts[0];
    }

    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Text(
              verseText(),
              style: TextStyle(
                color: darkGrey,
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookChapterVerse(BuildContext context) {
    return Text(
      verse,
      style: TextStyle(
        color: darkGrey,
        fontSize: getProportionateScreenHeight(14),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
