import 'package:flutter/material.dart';
import 'package:storefront/constants.dart';
import 'package:storefront/models/product.model.dart';
import 'package:storefront/screens/product-sub-details/product_sub_details_screen.dart';
import 'package:storefront/screens/products/products_screen.dart';
import 'package:storefront/size_config.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProductsScreen())),
            ),
            Text(
              widget.product.category!,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share_outlined,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15)),
            child: Text(
              '${widget.product.title}',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4),
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Stack(
              alignment: Alignment.centerLeft,
              fit: StackFit.loose,
              children: <Widget>[
                Positioned(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  top: getProportionateScreenWidth(40),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Positioned(
                  width: 200,
                  height: 200,
                  top: getProportionateScreenWidth(60),
                  left: getProportionateScreenWidth(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.remove_red_eye,
                        color: grayColor,
                        size: 24,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.006,
                      ),
                      Text(
                        '1.5 K',
                        style: TextStyle(color: grayColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Icon(
                        Icons.favorite,
                        color: grayColor,
                        size: 24,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.006,
                      ),
                      Text(
                        '216',
                        style: TextStyle(color: grayColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Icon(
                        Icons.shopping_bag,
                        color: grayColor,
                        size: 24,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.006,
                      ),
                      Text(
                        '120',
                        style: TextStyle(color: grayColor, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: getProportionateScreenHeight(280),
                      height: getProportionateScreenHeight(700),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: PageView(
                              onPageChanged: (value) => {
                                setState(() {
                                  currentPage = value;
                                  print('$currentPage');
                                })
                              },
                              children: [
                                InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductSubDetailsScreen(
                                                  product: widget.product))),
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 230,
                                    child: ClipRRect(
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.network(
                                            widget.product.image!),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductSubDetailsScreen(
                                                  product: widget.product))),
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    height: 230,
                                    child: ClipRRect(
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
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.04,
                          ),
                          Expanded(
                            flex: 2,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: 60,
                  height: 30,
                  top: getProportionateScreenWidth(65),
                  right: getProportionateScreenWidth(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.product.rating!.rate}',
                          style: TextStyle(color: primaryColor),
                        ),
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.amber[600],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  height: 100,
                  width: SizeConfig.screenWidth,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                  ),
                ),
                Positioned(
                  height: 300,
                  width: SizeConfig.screenWidth,
                  top: getProportionateScreenWidth(370),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${widget.product.price!.ceil().toDouble() + 10}',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w100,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '24%',
                                    style: TextStyle(
                                        color: Colors.greenAccent[400],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$ ${widget.product.price}',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.05,
                        ),
                        Text(
                          '${widget.product.title}',
                          style: TextStyle(color: grayColor),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        Text(
                          '${widget.product.description}',
                          style: TextStyle(color: grayColor),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Text(
                          'Choose Color',
                          style: TextStyle(color: primaryColor, fontSize: 20),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 30,
                                height: 30,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
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
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  height: 100,
                  width: SizeConfig.screenWidth,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(secondaryColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    color: primaryColor,
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.favorite_border,
                                      size: 24,
                                    )),
                              ],
                            )),
                        SizedBox(
                          width: SizeConfig.screenHeight * 0.01,
                        ),
                        Expanded(
                          flex: 10,
                          child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  secondaryColor,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      color: primaryColor,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_shopping_cart,
                                        size: 24,
                                      )),
                                  Text(
                                    'ADD TO CART',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 18),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
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
