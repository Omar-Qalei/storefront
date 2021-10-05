import 'package:flutter/material.dart';
import 'package:storefront/constants.dart';
import 'package:storefront/screens/login/login_screen.dart';
import 'package:storefront/size_config.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: getProportionateScreenWidth(400),
            child: Column(
              // Vertical
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.09,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(150),
                  height: getProportionateScreenHeight(150),
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.09,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenHeight * 0.02),
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.04,
                              ),
                              Form(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth -
                                          getProportionateScreenWidth(40),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          labelText: 'User Name',
                                          prefixIcon: const Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.white,
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          filled: true,
                                          fillColor: bgLightColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.03,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth -
                                          getProportionateScreenWidth(40),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          prefixIcon: const Icon(
                                            Icons.email_outlined,
                                            color: Colors.white,
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          filled: true,
                                          fillColor: bgLightColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.03,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth -
                                          getProportionateScreenWidth(40),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          prefixIcon: const Icon(
                                            Icons.vpn_key_outlined,
                                            color: Colors.white,
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          filled: true,
                                          fillColor: bgLightColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight * 0.03,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth -
                                          getProportionateScreenWidth(40),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          prefixIcon: const Icon(
                                            Icons.vpn_key_outlined,
                                            color: Colors.white,
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0),
                                          ),
                                          filled: true,
                                          fillColor: bgLightColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.07,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(
                              SizeConfig.screenWidth -
                                  getProportionateScreenWidth(40),
                              getProportionateScreenWidth(50),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(bgLightColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen())),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: primaryColor, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      const Text(
                        'already have an account',
                        style: TextStyle(color: primaryColor, fontSize: 13),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen())),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: pinkColor, fontSize: 12),
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
    );
  }
}
