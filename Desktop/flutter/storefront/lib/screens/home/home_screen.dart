import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storefront/constants.dart';
import 'package:storefront/screens/product-details/product_detials_screen.dart';
import 'package:storefront/screens/products/products_screen.dart';
import 'package:storefront/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> list = ['ALL', 'list', 'list', 'list', 'list', 'list', 'list'];
  List<bool> isSelected = [true, false, false, false, false, false, false];
  List<bool> isMenu = [true, false, false];
  int currentPage = 0;
  List<String> listItem = ['Page 1', 'Page 2', 'Page 3', 'Page 4'];
  late int _currentIndex = 0;
  late int _currentIndexB = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(13)),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 28,
                      color: primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                width: SizeConfig.screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(5)),
                child: SingleChildScrollView(
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
                                        builder: (context) =>
                                            ProductsScreen())),
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
              ),
              SizedBox(
                width: SizeConfig.screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(13)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Search Products...',
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 1.0),
                          ),
                          filled: true,
                          fillColor: secondaryColor,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenHeight(18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenHeight * 0.01,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(secondaryColor),
                          padding: MaterialStateProperty
                              .all<EdgeInsetsGeometry>(EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(0),
                                  vertical: getProportionateScreenHeight(15))),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                        ),
                        child: const Icon(
                          Icons.filter_list_outlined,
                          size: 24,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    SizeConfig.screenHeight - getProportionateScreenHeight(320),
                width: SizeConfig.screenWidth,
                child: PageView.builder(
                  allowImplicitScrolling: false,
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.data!.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) =>
                      pageBuilder(index),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: BottomNavyBar(
          backgroundColor: secondaryColor,
          mainAxisAlignment: MainAxisAlignment.center,
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: const Icon(Icons.apps),
                title: const Text('Home'),
                textAlign: TextAlign.center,
                inactiveColor: primaryColor,
                activeColor: primaryColor),
            BottomNavyBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                title: const Text(
                  'Shop',
                ),
                textAlign: TextAlign.center,
                inactiveColor: primaryColor,
                activeColor: primaryColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                title: const Text('Account'),
                textAlign: TextAlign.center,
                inactiveColor: primaryColor,
                activeColor: primaryColor),
          ],
        ),
      ),
    );
  }

  pageBuilder(int index) {
    var dismissibleKey = GlobalKey<State>();
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page! - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }
        return Center(
          child: Container(
            margin: EdgeInsets.only(top: 50, right: 20),
            height: Curves.easeOut.transform(value) *
                getProportionateScreenHeight(500),
            width: 400,
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                        product: products.data![index],
                      ))),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
                        child: Row(
                          children: [
                            Text(
                              'Company',
                              style: TextStyle(color: grayColor),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border_outlined,
                                    color: primaryColor)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 230,
                            child: Text(products.data![index].category!,
                                style: TextStyle(
                                    color: primaryColor,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),
                    Expanded(
                      flex: 10,
                      child: Image(
                        image: NetworkImage(
                            products.data![index].image.toString()),
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: bgColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.02,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: value * 10,
                                    vertical: value * 10),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: grayColor,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$ ${products.data![index].price}',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenHeight * 0.01,
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                  color: secondaryColor,
                ),
              ),
            ),
          ),
        );
      },
      // child: Dismissible(
      //   key: dismissibleKey,
      //   direction: DismissDirection.down,
      //   onDismissed: (DismissDirection direction) {
      //     /// Remove item from List
      //     setState(() {
      //       listItem.removeAt(index);
      //     });
      //   },
      //   child: InkWell(
      //     onLongPress: () {
      //       debugPrint('Delete! $index');
      //       setState(() {
      //         listItem.removeAt(index);
      //       });
      //     },
      //     onTap: () {
      //       controller.animateToPage(index,
      //           duration: Duration(milliseconds: 500), curve: Curves.ease);
      //     },
      //     child: Container(
      //       margin: const EdgeInsets.all(8.0),
      //       // color: index % 2 == 0 ? Colors.blue : Colors.red,
      //       color: Colors.lightBlueAccent,
      //       child: Center(
      //         child: Text('${listItem[index]}'),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
