import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/tab_box/cart/widgetss/cart_canceled_page.dart';
import 'package:planeta_uz/ui/tab_box/cart/widgetss/cart_history.dart';
import 'package:planeta_uz/ui/tab_box/cart/widgetss/cart_shipping_page.dart';
import 'package:planeta_uz/ui/tab_box/cart/widgetss/cart_waiting_screen.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({Key? key}) : super(key: key);

  @override
  _CartPageViewState createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    const CartWaitingPage(),
    const CartShippingPage(),
    const CartCanceledPage(),
    const CartHistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Pages'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 0;
              });
            },
            icon: const Icon(Icons.access_time),
            color: _currentIndex == 0 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            icon: const Icon(Icons.local_shipping),
            color: _currentIndex == 1 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            icon: const Icon(Icons.cancel),
            color: _currentIndex == 2 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 3;
              });
            },
            icon: const Icon(Icons.history),
            color: _currentIndex == 3 ? Colors.white : Colors.grey,
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CartPageView(),
  ));
}
