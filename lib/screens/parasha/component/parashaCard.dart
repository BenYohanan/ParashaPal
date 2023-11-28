import 'package:flutter/material.dart';
import 'package:pocket_siddur/models/parasha.dart';

import '../../../size_config.dart';

class ParashaScreenCard extends StatefulWidget {
  const ParashaScreenCard({
    Key? key,
    required this.parasha,
  }) : super(key: key);
  final Parasha parasha;

  @override
  State<ParashaScreenCard> createState() => _ParashaScreenCardState();
}

class _ParashaScreenCardState extends State<ParashaScreenCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Text(
            widget.parasha.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenHeight(15),
              fontWeight: FontWeight.w900,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DisplayReading(
                "Torah: ",
                widget.parasha.torah,
              ),
              DisplayReading(
                "Haf-Torah: ",
                widget.parasha.haftarah,
              ),
              DisplayReading(
                "Brit Chadasha: ",
                widget.parasha.britChadashah,
              ),
            ],
          ),
        ],
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
