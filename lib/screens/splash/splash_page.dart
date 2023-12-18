import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'intro_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 7000),
      vsync: this,
    );
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => IntroPage(),
      ),
    );
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(9, 65, 143, 0.678),
        image: DecorationImage(
          image: AssetImage(
            'assets/micha.png',
          ),
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  child: Opacity(
                    opacity: opacity.value,
                    child: Image.asset(
                      'assets/logo.png',
                      height: getProportionateScreenHeight(200),
                      width: getProportionateScreenHeight(200),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenHeight(
                    2,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Techiya',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
