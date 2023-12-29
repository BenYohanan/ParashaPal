import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/helpers/helpers.dart';
import 'package:pocket_siddur/screens/home/home.dart';
import 'package:pocket_siddur/size_config.dart';
import 'package:pocket_siddur/helpers/home_screen_details.dart';
import 'package:share_plus/share_plus.dart';

import '../../parasha/component/parashaSummary.dart';

class WeeklyParashah extends ConsumerStatefulWidget {
  WeeklyParashah({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<WeeklyParashah> createState() => _WeeklyParashahState();
}

class _WeeklyParashahState extends ConsumerState<WeeklyParashah> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var provider = ref.read(providerServiceProvider.notifier);
        var shabbathTime = provider.getLightingTime;
        var todaysEvent = provider.getEvents;
        var parasha = provider.getParasha;
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
                      color: primaryColor,
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
                          event,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: getProportionateScreenHeight(12),
                            fontWeight: FontWeight.w900,
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
              padding: EdgeInsets.only(top: 16.0),
              height: getProportionateScreenHeight(100),
              width: getProportionateScreenWidth(300),
              decoration: BoxDecoration(
                color: primaryColor,
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
                        parasha: parasha,
                        isFromHomepage: true,
                        route: MainPage.routeName,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            provider.decrementAddedDays(7);
                            Helper().updateHomeScreenDetails(provider);
                          },
                        );
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/backward.svg',
                        height: getProportionateScreenHeight(24),
                        width: getProportionateScreenWidth(24),
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        ShabbathCard(
                          'Shabbath',
                          getProportionateScreenHeight(20),
                        ),
                        ShabbathCard(
                          parasha.name,
                          getProportionateScreenHeight(15),
                        ),
                        ShabbathCard(
                          shabbathTime,
                          getProportionateScreenHeight(16),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            provider.incrementAddedDays(7);
                            Helper().updateHomeScreenDetails(provider);
                          },
                        );
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/forward.svg',
                        height: getProportionateScreenHeight(24),
                        width: getProportionateScreenWidth(24),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                right: getProportionateScreenHeight(50),
              ),
              child: GestureDetector(
                onTap: () {
                  var today = DateTime.now().weekday;
                  var message;
                  if (today == DateTime.friday) {
                    message =
                        'Thank Yahweh is Friday - #TYIF\n\nCheck out this week\'s Shabbath information\n${provider.getTodaysFormattedDate} \n\nParasha: ${parasha.name}\nReadings - Torah: ${parasha.torah} \nHaftarah: ${parasha.haftarah}\nBrit-Chadasha: ${parasha.britChadashah}.\n\n Thank you for studying, \n\n Download Parashah Pal at \n https://play.google.com/store/apps/details?id=parashapalapp.com.pocket_siddur';
                  } else {
                    message =
                        'Check out this week\'s Shabbath information\n${provider.getTodaysFormattedDate} \n\nParasha: ${parasha.name}\nReadings - Torah: ${parasha.torah} \nHaftarah: ${parasha.haftarah}\nBrit-Chadasha: ${parasha.britChadashah}.\n\n Thank you for studying, \n\n Download Parashah Pal at \n https://play.google.com/store/apps/details?id=parashapalapp.com.pocket_siddur';
                  }
                  Share.share(
                    message,
                    subject: 'Shabbath Information',
                    sharePositionOrigin: Rect.fromCenter(
                      center: Offset(0, 0),
                      width: 50,
                      height: 50,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/share.svg",
                      color: white,
                      height: getProportionateScreenHeight(30),
                    ),
                    Text(
                      'Share',
                      style: TextStyle(
                        color: white,
                      ),
                    )
                  ],
                ),
              ),
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
                color: primaryColor,
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
                  ShabbathCard(
                    'Weekly Reading',
                    getProportionateScreenHeight(18),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DisplayReading(
                        "Torah: ",
                        parasha.torah,
                      ),
                      DisplayReading(
                        "Haftarah: ",
                        parasha.haftarah,
                      ),
                      DisplayReading(
                        "Brit Chadasha: ",
                        parasha.britChadashah,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Text ShabbathCard(String name, double fontSize) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
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
              color: Colors.white,
              fontSize: getProportionateScreenHeight(17),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: reading,
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenHeight(14),
            ),
          ),
        ],
      ),
    );
  }
}
