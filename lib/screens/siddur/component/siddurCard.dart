import 'package:flutter/material.dart';
import 'package:pocket_siddur/models/prayer.dart';

import '../../../size_config.dart';
import '../../prayers/prayerScreen.dart';

class SiddurScreenCard extends StatefulWidget {
  const SiddurScreenCard({
    Key? key,
    required this.shabbathSiddur,
  }) : super(key: key);
  final Prayers shabbathSiddur;

  @override
  State<SiddurScreenCard> createState() => _SiddurScreenCardState();
}

class _SiddurScreenCardState extends State<SiddurScreenCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PrayerPage(
            prayer: widget.shabbathSiddur,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 16.0,
          right: 16.0,
          left: 16.0,
        ),
        height: getProportionateScreenHeight(110),
        width: getProportionateScreenWidth(300),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3, 3),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      widget.shabbathSiddur.header,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: getProportionateScreenHeight(16),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(3),
                    ),
                    DisplayReading(
                      "Prayer Type: ",
                      widget.shabbathSiddur.time,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(3),
                    ),
                    DisplayReading(
                      "Period: ",
                      widget.shabbathSiddur.name,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 16.0,
              ),
              height: getProportionateScreenHeight(70),
              child: Image.asset(
                widget.shabbathSiddur.image,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text DisplayReading(String title, String reading) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: getProportionateScreenHeight(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: reading,
            style: TextStyle(
              color: Colors.black54,
              fontSize: getProportionateScreenHeight(16),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }
}
