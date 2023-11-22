import 'package:card_swiper/card_swiper.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/models/prayer.dart';
import 'package:pocket_siddur/screens/prayers/prayer_page.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

class PrayerList extends StatelessWidget {
  List<Prayers> prayer;

  final SwiperController swiperController = SwiperController();

  PrayerList({
    required this.prayer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(300),
      child: Swiper(
        itemCount: prayer.length,
        itemBuilder: (_, index) {
          return PrayerCard(
            height: getProportionateScreenHeight(250),
            width: getProportionateScreenWidth(200),
            prayer: prayer[index],
          );
        },
        scale: 0.8,
        controller: swiperController,
        viewportFraction: 0.6,
        loop: false,
        fade: 0.5,
        pagination: SwiperCustomPagination(
          builder: (context, config) {
            Color activeColor = mediumYellow;
            Color color = Colors.grey.withOpacity(.3);
            double size = 10.0;
            double space = 5.0;
            if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                config.layout == SwiperLayout.DEFAULT) {
              return new PageIndicator(
                count: config.itemCount,
                controller: config.pageController!,
                layout: config.indicatorLayout,
                size: size,
                activeColor: activeColor,
                color: color,
                space: space,
              );
            }
            List<Widget> dots = [];
            int itemCount = config.itemCount;
            int activeIndex = config.activeIndex;

            for (int i = 0; i < itemCount; ++i) {
              bool active = i == activeIndex;
              dots.add(Container(
                key: Key("pagination_$i"),
                margin: EdgeInsets.all(space),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? activeColor : color,
                    ),
                    width: size,
                    height: size,
                  ),
                ),
              ));
            }
            return Padding(
              padding: EdgeInsets.all(
                getProportionateScreenHeight(
                  10,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: dots,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PrayerCard extends StatelessWidget {
  final Prayers prayer;
  final double height;
  final double width;

  const PrayerCard({
    required this.prayer,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PrayerPage(
            prayer: prayer,
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              left: 30,
            ),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
              color: mediumYellow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                  onPressed: () {},
                  color: Colors.white,
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(
                          getProportionateScreenHeight(
                            8,
                          ),
                        ),
                        child: Text(
                          prayer.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionateScreenHeight(
                              15,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        padding: const EdgeInsets.fromLTRB(
                          8.0,
                          4.0,
                          12.0,
                          4.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(
                              5,
                            ),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(5),
                          ),
                          color: darkGrey,
                        ),
                        child: Text(
                          '${prayer.time}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionateScreenHeight(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            child: Hero(
              tag: prayer.image,
              child: Image.asset(
                prayer.image,
                height: getProportionateScreenHeight(170),
                width: getProportionateScreenWidth(140),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
