import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/constants.dart';
import 'package:shoes_shop/models/cart.dart';
import 'package:shoes_shop/models/shoe.dart';
import 'package:shoes_shop/providers/cart_provider.dart';
import 'package:shoes_shop/providers/shoe_provider.dart';

class ListItemCart extends StatefulWidget {
  final Cart cart;
  final int index;

  const ListItemCart({
    super.key,
    required this.cart,
    required this.index,
  });

  @override
  State<ListItemCart> createState() => _ListItemCartState();
}

class _ListItemCartState extends State<ListItemCart> {
  @override
  Widget build(BuildContext context) {
    String? colorShoe = widget.cart.color?.substring(1);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Stack(
      children: [
        Container(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Color(int.parse('0xFF${colorShoe!}')),
                      shape: BoxShape.circle),
                ),
              ),
              Transform.rotate(
                  angle: -pi / 7,
                  origin: const Offset(-110, 50),
                  child: Image.network(
                    "${widget.cart.image}",
                    height: 150,
                    width: 150,
                  )),
            ],
          ),
        ),
        Positioned(
          left: 110,
          right: 0,
          top: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.cart.name}',
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Rubik-Bold',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "\$${widget.cart.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Rubik-Bold',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFe1e7ed).withOpacity(0.7),
                        shape: const CircleBorder(
                          side: BorderSide.none,
                        ),
                      ),
                      onPressed: () {
                        if (widget.cart.number == 1) {
                          cartProvider
                              .removeShoeInCart(widget.index)
                              .whenComplete(() {
                            cartProvider.getAllShoeInCart();
                            
                          });
                          setState(() {});
                        } else {
                          cartProvider
                              .updateShoeInCart(
                                  Cart(
                                      id: widget.cart.id,
                                      image: widget.cart.image,
                                      name: widget.cart.name,
                                      number: widget.cart.number! - 1,
                                      color: widget.cart.color,
                                      price: widget.cart.price),
                                  widget.index)
                              .whenComplete(
                                  () => cartProvider.getAllShoeInCart());
                        }
                      },
                      child: Image.asset(
                        'assets/images/minus.png',
                        height: 7,
                        width: 7,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${widget.cart.number}',
                      style: const TextStyle(
                          fontSize: 14, fontFamily: 'Rubik-Light'),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFe1e7ed).withOpacity(0.7),
                        shape: const CircleBorder(
                          side: BorderSide.none,
                        ),
                      ),
                      onPressed: () {
                        cartProvider
                            .updateShoeInCart(
                                Cart(
                                    id: widget.cart.id,
                                    image: widget.cart.image,
                                    name: widget.cart.name,
                                    number: widget.cart.number! + 1,
                                    color: widget.cart.color,
                                    price: widget.cart.price),
                                widget.index)
                            .whenComplete(
                                () => cartProvider.getAllShoeInCart());
                      },
                      child: Image.asset(
                        'assets/images/plus.png',
                        height: 7,
                        width: 7,
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.colorYellow,
                        shape: const CircleBorder(
                          side: BorderSide.none,
                        ),
                      ),
                      onPressed: () {
                        cartProvider
                            .removeShoeInCart(widget.index)
                            .whenComplete(() {
                          cartProvider.getAllShoeInCart();
                        });
                      },
                      child: Image.asset(
                        'assets/images/trash.png',
                        height: 15,
                        width: 15,
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
