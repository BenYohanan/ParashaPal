import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/models/prayer.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

import 'components/product_display.dart';

class PrayerPage extends StatefulWidget {
  final Prayers prayer;

  PrayerPage({required this.prayer});

  @override
  _PrayerPageState createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.prayer.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: getProportionateScreenHeight(16),
          ),
        ),
      ),
      body: Scrollbar(
        trackVisibility: true,
        thickness: 8,
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            ProductDisplay(
              product: widget.prayer,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 16.0,
              ),
              child: Text(
                widget.prayer.header,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFFEFEFE),
                  fontWeight: FontWeight.w600,
                  fontSize: getProportionateScreenHeight(15),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 40.0,
                bottom: 130,
              ),
              child: Text(
                widget.prayer.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: const Color(0xfefefefe),
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: getProportionateScreenHeight(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
