import 'package:flutter/material.dart';
import 'package:pocket_siddur/models/blessings.dart';

import '../../../size_config.dart';

class BlessingScreenCard extends StatefulWidget {
  const BlessingScreenCard({
    Key? key,
    required this.blessing,
  }) : super(key: key);
  final Blessing blessing;

  @override
  State<BlessingScreenCard> createState() => _BlessingScreenCardState();
}

class _BlessingScreenCardState extends State<BlessingScreenCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.0,
        right: 16.0,
        left: 16.0,
      ),
      height: getProportionateScreenHeight(90),
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
          blessingDisplay(widget.blessing.name),
          SizedBox(height: 10),
          blessingDisplay("Description: ${widget.blessing.shortDescriptionAboutPrayer}")
        ],
      ),
    );
  }

  Align blessingDisplay(String name) {
    return Align(
          alignment: Alignment.topLeft,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black54,
              fontSize: getProportionateScreenHeight(15),
              fontWeight: FontWeight.w900,
            ),
          ),
        );
  }
}
