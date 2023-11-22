import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/models/prayer.dart';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

class ProductDisplay extends StatelessWidget {
  final Prayers product;

  const ProductDisplay({
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 30.0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: getProportionateScreenHeight(60),
            padding: EdgeInsets.only(right: 24),
            decoration: new BoxDecoration(
                color: darkGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(
                    8.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                      offset: Offset(0, 3),
                      blurRadius: 6.0),
                ]),
            child: Align(
              alignment: Alignment(1, 0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${product.time}',
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400,
                        fontSize: getProportionateScreenHeight(15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(-1, 0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              height: screenAwareSize(200, context),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Container(
                      child: Hero(
                        tag: product.image,
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                          height: getProportionateScreenWidth(200),
                          width: getProportionateScreenWidth(230),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          bottom: 0.0,
          child: RawMaterialButton(
            onPressed: () {},
            constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
            child: Icon(
              Icons.favorite,
              color: Color.fromRGBO(
                255,
                137,
                147,
                1,
              ),
            ),
            elevation: 0.0,
            shape: CircleBorder(),
            fillColor: Color.fromRGBO(
              255,
              255,
              255,
              0.4,
            ),
          ),
        )
      ],
    );
  }
}
