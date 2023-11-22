import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/screens/home/home.dart';

import '../../../enum.dart';
import '../../../size_config.dart';

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
                  ? darkYellow
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
                  ? darkYellow
                  : inActiveIconColor,
            ),
            label: 'Blessings',
            onTap: () {},
          ),
          buildNavBarItem(
            icon: SvgPicture.asset(
              "assets/icons/music.svg",
              height: 20,
              width: 20,
              color: NavBarMenuState.songs == widget.selectedMenu
                  ? darkYellow
                  : inActiveIconColor,
            ),
            label: 'Tehillim',
            onTap: () {},
          ),
          buildNavBarItem(
            icon: SvgPicture.asset(
              "assets/icons/events.svg",
              height: 20,
              width: 20,
              color: NavBarMenuState.festivals == widget.selectedMenu
                  ? darkYellow
                  : inActiveIconColor,
            ),
            label: 'Festivals',
            onTap: () {},
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
