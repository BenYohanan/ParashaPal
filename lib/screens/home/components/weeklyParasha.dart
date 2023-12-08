import 'package:carousel_slider/carousel_slider.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/screens/home/home.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../../models/parasha.dart';
import '../../parasha/component/parashaSummary.dart';

class WeeklyParashah extends StatelessWidget {
  WeeklyParashah(
      {Key? key,
      required this.shabbathTime,
      required this.todaysEvent,
      required this.parasha})
      : super(key: key);
  final Parasha? parasha;
  final String? shabbathTime;
  final List<String> todaysEvent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: getProportionateScreenHeight(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 8.0,
                  ),
                  width: getProportionateScreenWidth(3),
                  color: transparentYellow,
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    padEnds: false,
                    height: getProportionateScreenHeight(50),
                    viewportFraction: 1.0,
                  ),
                  items: todaysEvent.map((event) {
                    return Text(
                      event.isEmpty
                          ? "No special event today – take a moment for personal reflection."
                          : event,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: getProportionateScreenHeight(12),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(8),
        ),
        Container(
          padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
          height: getProportionateScreenHeight(100),
          width: getProportionateScreenWidth(300),
          decoration: BoxDecoration(
            color: transparentYellow,
            boxShadow: [
              BoxShadow(
                color: Colors.white24,
                offset: Offset(0, 3),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => ParashaSummaryPage(
                    parasha: parasha!,
                     route: MainPage.routeName,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Shabbath',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenHeight(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      parasha!.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenHeight(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      shabbathTime!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 16.0,
            right: 16.0,
            left: 16.0,
          ),
          height: getProportionateScreenHeight(110),
          width: getProportionateScreenWidth(300),
          decoration: BoxDecoration(
            color: transparentYellow,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 81, 78, 78),
                offset: Offset(0, 3),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Column(
            children: [
              Text(
                'Weekly Reading',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayReading(
                    "Torah: ",
                    parasha!.torah,
                  ),
                  DisplayReading(
                    "Haf-Torah: ",
                    parasha!.haftarah,
                  ),
                  DisplayReading(
                    "Brit Chadasha: ",
                    parasha!.britChadashah,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Text DisplayReading(String title, String reading) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenHeight(17),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: reading,
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenHeight(16),
            ),
          ),
        ],
      ),
    );
  }
}
