import 'package:pocket_siddur/app_properties.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';
import '../splash/intro_page.dart';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  @override
  Widget build(BuildContext context) {
    Widget welcomeBack = Text(
      'Shalom Alechiem',
      style: TextStyle(
        color: Colors.white,
        fontSize: getProportionateScreenHeight(20),
        fontWeight: FontWeight.bold,
        shadows: [
          BoxShadow(
            color: Colors.white12,
            offset: Offset(0, 10),
            blurRadius: 10.0,
          )
        ],
      ),
    );

    Widget subTitle = Padding(
      padding: EdgeInsets.only(
        right: getProportionateScreenHeight(
          56.0,
        ),
      ),
      child: Text(
        "Step into a world of spiritual connection with Pocket Siddur,\n"
        " your go-to Jewish prayer app.\n"
        "Foster a deeper connection with your faith, all in one convenient place.\n"
        "Welcome to a seamless prayer experience, designed to bring the \n"
        "beauty of Jewish traditions to your fingertips.",
        style: TextStyle(
          color: Colors.white,
          fontSize: getProportionateScreenHeight(17),
        ),
      ),
    );

    Widget continueButton = Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: getProportionateScreenWidth(70),
            bottom: getProportionateScreenHeight(50),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => IntroPage(),
                  ),
                );
              },
              child: Container(
                width: getProportionateScreenWidth(200),
                height: getProportionateScreenHeight(50),
                child: Center(
                  child: new Text(
                    "Continue",
                    style: TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: getProportionateScreenHeight(16),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: darkGrey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white24,
                      offset: Offset(0, 3),
                      blurRadius: 10.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(9.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget poweredBy = Padding(
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Powered by ',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Ben Yohanan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/tallit.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: transparentYellow,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenHeight(
                28,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                welcomeBack,
                Spacer(
                  flex: 3,
                ),
                subTitle,
                Spacer(flex: 3),
                continueButton,
                Spacer(flex: 2),
                poweredBy
              ],
            ),
          )
        ],
      ),
    );
  }
}
