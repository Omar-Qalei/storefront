import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storefront/constants.dart';
import 'package:storefront/models/product.model.dart';
import 'package:storefront/size_config.dart';

class ProductSubDetailsScreen extends StatefulWidget {
  const ProductSubDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  State<ProductSubDetailsScreen> createState() =>
      _ProductSubDetailsScreenState();
}

class _ProductSubDetailsScreenState extends State<ProductSubDetailsScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
              child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(200),
              child: Text(
                widget.product.title!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15)),
              child: Text(
                widget.product.title!,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15)),
              child: Text(
                widget.product.category!,
                style: TextStyle(
                  color: grayColor,
                ),
              ),
            ),

            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              color: grayColor,
                              size: 16,
                            ),
                            SizedBox(
                              width: SizeConfig.screenHeight * 0.006,
                            ),
                            Text(
                              '1.5 K',
                              style: TextStyle(color: grayColor),
                            ),
                            SizedBox(
                              width: SizeConfig.screenHeight * 0.03,
                            ),
                            Icon(
                              Icons.favorite,
                              color: grayColor,
                              size: 16,
                            ),
                            SizedBox(
                              width: SizeConfig.screenHeight * 0.006,
                            ),
                            Text(
                              '212',
                              style: TextStyle(color: grayColor),
                            ),
                            SizedBox(
                              width: SizeConfig.screenHeight * 0.03,
                            ),
                            Icon(
                              Icons.shopping_bag,
                              color: grayColor,
                              size: 16,
                            ),
                            SizedBox(
                              width: SizeConfig.screenHeight * 0.006,
                            ),
                            Text(
                              '120',
                              style: TextStyle(color: grayColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: getProportionateScreenHeight(90),
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.orientation == Orientation.landscape
                          ? getProportionateScreenHeight(600)
                          : getProportionateScreenHeight(400),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 30,
                            child: PageView(
                              onPageChanged: (value) => {
                                setState(() {
                                  currentPage = value;
                                  print('$currentPage');
                                })
                              },
                              children: [
                                InkWell(
                                  onTap: () {
                                    print("Container clicked");
                                  },
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.network(
                                            widget.product.image!),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("Container clicked");
                                  },
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.network(
                                            widget.product.image!),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    2,
                                    (index) => buildDot(index: index),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Image(
            //   image: NetworkImage('https://via.placeholder.com/200'),
            //   fit: BoxFit.cover,
            //   height: 300,
            //   width: SizeConfig.screenWidth,
            // ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? primaryColor : null,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: primaryColor, width: 1)),
    );
  }
}
