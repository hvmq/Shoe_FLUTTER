import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/constants.dart';
import 'package:shoes_shop/models/cart.dart';
import 'package:shoes_shop/providers/cart_provider.dart';
import 'package:shoes_shop/providers/shoe_provider.dart';
import 'package:shoes_shop/screens/widget/custom_pain.dart';
import 'package:shoes_shop/screens/widget/list_item_cart.dart';
import 'package:shoes_shop/screens/widget/list_item_shop.dart';

import '../models/shoe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  totalCart(List<Cart> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      total = total + (list[i].price! * list[i].number!);
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // var box = await Hive.openBox<Shoe>('shoeBox');
      // box.clear();
      Provider.of<ShoeProvider>(context, listen: false)
          .getAllProductsServerandSaveLocal();
      Provider.of<ShoeProvider>(context, listen: false).getAllShoesLocal();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      body: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, size.height),
            painter: RPSCustomPainter(),
          ),
          SingleChildScrollView(
            child: size.width < 800
                ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 600,
                          width: 350,
                          decoration: BoxDecoration(
                              color: AppColor.colorWhite,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.colorGray.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ]),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CustomPaint(
                                  size: Size(size.width, size.height),
                                  painter: ContainerCustomPainter(),
                                ),
                              ),
                              Positioned(
                                  top: 7,
                                  left: 20,
                                  child: Image.asset(
                                    "assets/images/nike.png",
                                    width: 50,
                                    height: 40,
                                  )),
                              const Positioned(
                                left: 20,
                                top: 60,
                                child: Text(
                                  "Our Products",
                                  style: TextStyle(
                                      fontSize: 25, fontFamily: "Rubik-Bold"),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 0,
                                child: Consumer<ShoeProvider>(
                                    builder: (context, shoeData, child) =>
                                        SizedBox(
                                          height: 490,
                                          width: 310,
                                          child: SingleChildScrollView(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    shoeData.shoes.length,
                                                itemBuilder: (context, index) {
                                                  return ListItemShop(
                                                      shoe:
                                                          shoeData.shoes[index],
                                                      onClicked: () {});
                                                }),
                                          ),
                                        )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Consumer<CartProvider>(
                          builder: (context, cartData, child) => Container(
                            height: 600,
                            width: 350,
                            decoration: BoxDecoration(
                                color: AppColor.colorWhite,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.colorGray.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 4),
                                  ),
                                ]),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CustomPaint(
                                    size: Size(size.width, size.height),
                                    painter: ContainerCustomPainter(),
                                  ),
                                ),
                                Positioned(
                                    top: 7,
                                    left: 20,
                                    child: Image.asset(
                                      "assets/images/nike.png",
                                      width: 50,
                                      height: 40,
                                    )),
                                const Positioned(
                                  left: 20,
                                  top: 60,
                                  child: Text(
                                    "Your Cart",
                                    style: TextStyle(
                                        fontSize: 25, fontFamily: "Rubik-Bold"),
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  top: 60,
                                  child: Text(
                                    "\$${(totalCart(cartData.carts)).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 25, fontFamily: "Rubik-Bold"),
                                  ),
                                ),
                                Positioned(
                                    left: 20,
                                    bottom: 0,
                                    child: SizedBox(
                                      height: 490,
                                      width: 310,
                                      child: SingleChildScrollView(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: cartData.carts.length,
                                            itemBuilder: (context, index) {
                                              return ListItemCart(
                                                cart: cartData.carts[index],
                                                index: index,
                                              );
                                            }),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 600,
                          width: 350,
                          decoration: BoxDecoration(
                              color: AppColor.colorWhite,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.colorGray.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ]),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CustomPaint(
                                  size: Size(size.width, size.height),
                                  painter: ContainerCustomPainter(),
                                ),
                              ),
                              Positioned(
                                  top: 7,
                                  left: 20,
                                  child: Image.asset(
                                    "assets/images/nike.png",
                                    width: 50,
                                    height: 40,
                                  )),
                              const Positioned(
                                left: 20,
                                top: 60,
                                child: Text(
                                  "Our Products",
                                  style: TextStyle(
                                      fontSize: 25, fontFamily: "Rubik-Bold"),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 0,
                                child: Consumer<ShoeProvider>(
                                    builder: (context, shoeData, child) =>
                                        SizedBox(
                                          height: 490,
                                          width: 310,
                                          child: SingleChildScrollView(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: shoeData.shoes.length,
                                                itemBuilder: (context, index) {
                                                  return ListItemShop(
                                                      shoe: shoeData.shoes[index],
                                                      onClicked: () {
                                                        setState(() {});
                                                      });
                                                }),
                                          ),
                                        )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Consumer<CartProvider>(
                          builder: (context, cartData, child) => Container(
                            height: 600,
                            width: 350,
                            decoration: BoxDecoration(
                                color: AppColor.colorWhite,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.colorGray.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 4),
                                  ),
                                ]),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CustomPaint(
                                    size: Size(size.width, size.height),
                                    painter: ContainerCustomPainter(),
                                  ),
                                ),
                                Positioned(
                                    top: 7,
                                    left: 20,
                                    child: Image.asset(
                                      "assets/images/nike.png",
                                      width: 50,
                                      height: 40,
                                    )),
                                const Positioned(
                                  left: 20,
                                  top: 60,
                                  child: Text(
                                    "Your Cart",
                                    style: TextStyle(
                                        fontSize: 25, fontFamily: "Rubik-Bold"),
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  top: 60,
                                  child: Text(
                                    "\$${(totalCart(cartData.carts)).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 25, fontFamily: "Rubik-Bold"),
                                  ),
                                ),
                                cartData.carts.isEmpty
                                      ? const Positioned(
                                        left: 20,
                                        top: 100,
                                        child: Text('Your cart is empty.'))
                                :Positioned(
                                    left: 20,
                                    bottom: 0,
                                    child: SizedBox(
                                      height: 490,
                                      width: 310,
                                      child: 
                                      SingleChildScrollView(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: cartData.carts.length,
                                            itemBuilder: (context, index) {
                                              return ListItemCart(
                                                cart: cartData.carts[index],
                                                index: index,
                                              );
                                            }),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                ),
          ),
        ],
      ),
    );
  }
}
