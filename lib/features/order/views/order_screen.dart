import 'package:ddnangcao_project/features/add_to_cart/views/cart_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_lib.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("My Order"),
          bottom: const TabBar(
            padding: EdgeInsets.symmetric(horizontal: 0),
            isScrollable: true,
            indicatorColor: ColorLib.primaryColor,
            indicatorWeight: 5,
            tabs: [
              RepeatedTab(
                label: "Outgoing",
              ),
              RepeatedTab(
                label: "History",
              ),
              RepeatedTab(
                label: "To rate",
              ),
              RepeatedTab(
                label: "Cart",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text("Men"),
            ),
            Center(
              child: Text("Women"),
            ),
            Center(
              child: Text("Shoes"),
            ),
            CartScreen(),
          ],
        ),
      ),
    );
  }
}


class RepeatedTab extends StatelessWidget {
  final String label;

  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}


class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            const Text(
              "What are you looking for?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Container(
              height: 32,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.yellow),
              child: const Center(
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}