import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storefront/constants.dart';
import 'package:storefront/screens/home/home_screen.dart';
import 'package:storefront/screens/product-details/product_detials_screen.dart';
import 'package:storefront/size_config.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<String> list = ['ALL', 'list', 'list', 'list', 'list', 'list', 'list'];

  List<bool> isSelected = [true, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/menu.svg'),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_none_outlined))
        ],
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(13)),
                    child: ToggleButtons(
                      color: secondaryColor,
                      selectedColor: primaryColor,
                      borderColor: Colors.transparent,
                      fillColor: Colors.transparent,
                      borderWidth: 0,
                      splashColor: Colors.transparent,
                      selectedBorderColor: Colors.transparent,
                      children: List.generate(
                        list.length,
                        (index) => Container(
                          margin: EdgeInsets.only(
                              right: getProportionateScreenWidth(62)),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen())),
                            child: Text(
                              list[index],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: getProportionateScreenHeight(70)),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 350,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                itemCount: products.data!.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                          product: products.data![index]))),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${products.data![index].rating!.rate}',
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber[600],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.favorite, color: primaryColor))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Image(
                                  image: NetworkImage(
                                      products.data![index].image.toString()),
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                right: 5,
                                bottom: 5,
                                width: 50,
                                height: 50,
                                child: TextButton(
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                                  product:
                                                      products.data![index]))),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(bgColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                  ),
                                  child: Icon(
                                    Icons.add_shopping_cart_sharp,
                                    size: 24,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.03,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: getProportionateScreenWidth(150),
                                        child: Text(
                                          products.data![index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.screenHeight * 0.02,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$ ${products.data![index].price}',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.screenHeight * 0.01,
                                          ),
                                          Text(
                                            '\$ ${products.data![index].price!.ceil().toDouble() + 10}',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w100,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      color: secondaryColor,
                    ),
                  ),
                ),
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                //   crossAxisSpacing: 10,
                //   mainAxisSpacing: 10,
                //   childAspectRatio: 1,
                // ),
              ),
            ),
          ],
        ),
      ),
      // GridView.count(
      //   crossAxisCount: 2,
      //   // Create a grid with 2 columns. If you change the scrollDirection to
      //   // horizontal, this produces 2 rows.
      //   // Generate 100 widgets that display their index in the List.
      //   children: [
      //     ...List.generate(100, (index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Container(
      //           width: 300,
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: <Widget>[
      //               Column(
      //                 children: [
      //                   Text('4.5'),
      //                   Icon(
      //                     Icons.star_rate_rounded,
      //                     color: Colors.amber[600],
      //                   ),
      //                   Spacer(),
      //                   IconButton(
      //                       onPressed: () {}, icon: Icon(Icons.favorite))
      //                 ],
      //               ),
      //               Image.network('https://via.placeholder.com/150')
      //             ],
      //           ),
      //           decoration: const BoxDecoration(
      //               borderRadius: BorderRadius.all(
      //                 Radius.circular(20.0),
      //               ),
      //               color: secondaryColor),
      //         ),
      //       );
      //     }),
      //   ],
      // )
    );
  }
}
