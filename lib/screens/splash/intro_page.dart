import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/helpers/home_screen_details.dart';
import 'package:pocket_siddur/helpers/helpers.dart';
import 'package:pocket_siddur/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

class IntroPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends ConsumerState<IntroPage> {
  PageController controller = PageController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var provider = ref.read(providerServiceProvider.notifier);
    String locationName = provider.getUserLocation.locationName!;
    if (locationName.isEmpty) {
      Helper().updateHomeScreenDetails(provider);
    }
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 245, 245),
        ),
        child: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (value) {
                setState(
                  () {
                    pageIndex = value;
                  },
                );
              },
              controller: controller,
              children: <Widget>[
                IntroPageWidget(
                  'assets/micha.png',
                  'Perform Mitzvoth On The Goal',
                  'Welcome to a seamless prayer experience, designed to bring the beauty of Jewish traditions to your fingertips.',
                ),
                IntroPageWidget(
                  'assets/torah.png',
                  'Never Miss A Single Prayer',
                  'Foster a deeper connection with your faith, all in one convenient place.',
                ),
                IntroPageWidget(
                  'assets/kiddush.png',
                  'Tefillin',
                  'Step into a world of spiritual connection with Parasha Pal: Shabbat Messianic Siddur, your go-to Jewish prayer app.',
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            color: pageIndex == 0 ? darkGrey : Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            color: pageIndex == 1 ? darkGrey : Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            color: pageIndex == 2 ? darkGrey : Colors.white,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Opacity(
                          opacity: pageIndex != 2 ? 1.0 : 0.0,
                          child: TextButton(
                            child: Text(
                              'SKIP',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenHeight(16),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        pageIndex != 2
                            ? TextButton(
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenHeight(16),
                                  ),
                                ),
                                onPressed: () {
                                  if (!(controller.page == 2.0))
                                    controller.nextPage(
                                      duration: Duration(
                                        milliseconds: 200,
                                      ),
                                      curve: Curves.linear,
                                    );
                                },
                              )
                            : TextButton(
                                child: Text(
                                  'FINISH',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenHeight(16),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => MainPage(),
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column IntroPageWidget(String image, String header, String content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Center(
          child: Image.asset(
            image,
            height: 200,
            width: 200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Text(
            header,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16.0,
          ),
          child: Text(
            content,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black87,
              fontSize: getProportionateScreenHeight(14),
            ),
          ),
        ),
      ],
    );
  }
}
