import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/helpers/home_screen_details.dart';
import 'package:pocket_siddur/helpers/home_screen_details_repository.dart';
import 'package:pocket_siddur/size_config.dart';

class VerseOfTheDayCard extends ConsumerStatefulWidget {
  @override
  _VerseOfTheDayCardState createState() => _VerseOfTheDayCardState();
}

class _VerseOfTheDayCardState extends ConsumerState<VerseOfTheDayCard> {
  DateTime lastUpdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = ref.read(providerServiceProvider.notifier);
    
    Color bgColor() {
      // Use Material Theme's brightness to determine the background color
      return Theme.of(context).brightness == Brightness.dark ? Colors.grey[800]! : Colors.grey[300]!;
    }

    return Container(
      width: getProportionateScreenWidth(350),
      padding: EdgeInsets.all(getProportionateScreenHeight(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).canvasColor, // Use Material theme's canvas color
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
                    SizedBox(height: getProportionateScreenHeight(5)),
                    _body(context, bgColor(), provider),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    _bookChapterVerse(context, provider),
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

  Widget _body(BuildContext context, Color bgColor, ProviderService provider) {
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
              provider.getVerseOfTheDay.message!,
              style: TextStyle(
                color: Colors.black45,
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

  Widget _bookChapterVerse(BuildContext context, ProviderService provider) {
    return Text(
      provider.getVerseOfTheDay.verse!,
      style: TextStyle(
        color: Colors.black54,
        fontSize: getProportionateScreenHeight(14),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
