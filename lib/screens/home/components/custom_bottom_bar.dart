import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/screens/home/home.dart';
import 'package:pocket_siddur/screens/siddur/siddurScreen.dart';

import '../../../enum.dart';
import '../../../size_config.dart';
import '../../parasha/parashaScreen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final NavBarMenuState selectedMenu;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  Color inActiveIconColor = const Color(0xFFB6B6B6);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        getProportionateScreenHeight(
          8,
        ),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildNavBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              height: 20,
              width: 20,
              color: NavBarMenuState.home == widget.selectedMenu
                  ? transparentYellow
                  : inActiveIconColor,
            ),
            label: 'Home',
            onTap: () => Navigator.pushNamed(
              context,
              MainPage.routeName,
            ),
          ),
          buildNavBarItem(
              icon: SvgPicture.asset(
                "assets/icons/category_icon.svg",
                height: 20,
                width: 20,
                color: NavBarMenuState.blessings == widget.selectedMenu
                    ? darkGrey
                    : inActiveIconColor,
              ),
              label: 'Blessings',
              onTap: () {}),
          buildNavBarItem(
            icon: SvgPicture.asset(
              "assets/icons/jewish-candles.svg",
              height: 20,
              width: 20,
              color: NavBarMenuState.siddur == widget.selectedMenu
                  ? darkGrey
                  : inActiveIconColor,
            ),
            label: 'Siddur',
            onTap: () => Navigator.pushNamed(
              context,
              SiddurScreen.routeName,
            ),
          ),
          buildNavBarItem(
            icon: SvgPicture.asset(
              "assets/icons/jewish-faith.svg",
              height: 20,
              width: 20,
              color: NavBarMenuState.parasha == widget.selectedMenu
                  ? darkGrey
                  : inActiveIconColor,
            ),
            label: 'Parashot',
            onTap: () => Navigator.pushNamed(
              context,
              ParaShaScreen.routeName,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavBarItem({
    required Widget icon,
    required String label,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          Text(
            label,
            style: TextStyle(
              color: inActiveIconColor,
              fontSize: getProportionateScreenHeight(10),
            ),
          ),
        ],
      ),
    );
  }
}
