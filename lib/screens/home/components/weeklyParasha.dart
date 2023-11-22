import 'package:carousel_slider/carousel_slider.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

class WeeklyParashah extends StatelessWidget {
  WeeklyParashah(
      {Key? key,
      required this.torahReading,
      required this.hafTorah,
      required this.britChadasha,
      required this.shabbathTime,
      required this.todaysEvent,
      required this.parasha})
      : super(key: key);
  final String? parasha;
  final String? torahReading;
  final String? hafTorah;
  final String? britChadasha;
  final String? shabbathTime;
  final String? todaysEvent;
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
                  color: mediumYellow,
                ),
              ),
              Container(
                width: getProportionateScreenWidth(350),
                height: getProportionateScreenWidth(350),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    padEnds: false,
                    height: getProportionateScreenHeight(50),
                    viewportFraction: 1.0,
                  ),
                  items: [
                    Container(
                      width: getProportionateScreenWidth(350),
                      height: getProportionateScreenWidth(350),
                      child: Text(
                        todaysEvent!.isEmpty
                            ? "No special event today – take a moment for personal reflection."
                            : todaysEvent!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: getProportionateScreenHeight(12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    parasha!,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: getProportionateScreenHeight(25),
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
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
          height: getProportionateScreenHeight(100),
          width: getProportionateScreenWidth(300),
          decoration: BoxDecoration(
            color: transparentYellow,
            boxShadow: [
              BoxShadow(
                  color: Colors.white24, offset: Offset(0, 3), blurRadius: 10.0)
            ],
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Column(
            children: [
              Text(
                'Weekly Reading',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayReading(
                    "Torah: ",
                    torahReading!,
                  ),
                  DisplayReading(
                    "Haf-Torah: ",
                    hafTorah!,
                  ),
                  DisplayReading(
                    "Brit Chadasha: ",
                    britChadasha!,
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
              color: Colors.white70,
              fontSize: getProportionateScreenHeight(17),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: reading,
            style: TextStyle(
              color: Colors.white60,
              fontSize: getProportionateScreenHeight(16),
            ),
          ),
        ],
      ),
    );
  }
}
