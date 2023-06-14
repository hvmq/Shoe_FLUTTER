import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/models/cart.dart';
import 'package:shoes_shop/models/shoe.dart';
import 'package:shoes_shop/providers/cart_provider.dart';
import 'package:shoes_shop/providers/shoe_provider.dart';
import 'package:shoes_shop/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ShoeAdapter());
  await Hive.openBox<Shoe>('shoeBox');
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox<Cart>('cartBox');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: ShoeProvider()),
      ChangeNotifierProvider.value(value: CartProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
