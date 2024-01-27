import 'package:ddnangcao_project/features/add_to_cart/controllers/add_to_cart_controller.dart';
import 'package:flutter/material.dart';
import '../../../models/food_cart.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/global_variable.dart';
import '../../../utils/size_lib.dart';
import '../../../utils/snack_bar.dart';
import '../../main/views/food_category_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<FoodCartModel> listCart = [];
  final AddToCartController addToCartController = AddToCartController();

  getAllCart() async {
    listCart = await addToCartController.getAllCart();
  }

  decrementCart(int index) async {
    print(listCart[index].food?.id);
    String message = await addToCartController
        .updateCartDecrement("${listCart[index].food?.id}");
    if (message == GlobalVariable.updateCartSuc) {
      ShowSnackBar().showSnackBar(message, Colors.green, Colors.white, context);
      setState(() {
        listCart[index].number = listCart[index].number! - 1;
      });
    } else {
      ShowSnackBar().showSnackBar("Fail to decrement value of cart",
          ColorLib.primaryColor, Colors.white, context);
    }
  }

  increment(int index) async {
    String message = await addToCartController
        .updateCartIncrement("${listCart[index].food?.id}");
    if (message == GlobalVariable.updateCartSuc) {
      ShowSnackBar().showSnackBar(message, Colors.green, Colors.white, context);
      setState(() {
        listCart[index].number = listCart[index].number! - 1;
      });
    } else {
      ShowSnackBar().showSnackBar("Fail to increment value of cart",
          ColorLib.primaryColor, Colors.white, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              FutureBuilder(
                future: getAllCart(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listCart.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: FoodOfRestaurant(
                                increment: (){
                                  increment(index);
                                },
                                decrement: (){
                                  decrementCart(index);
                                },
                                name: listCart[index].food?.name ?? "",
                                index: index + 1,
                                price: listCart[index].food?.price ?? 0,
                                number: listCart[index].number ?? 0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listCart.length,
                          itemBuilder: (context, index) =>
                              const CardSkeltonOrderRestaurant(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodOfRestaurant extends StatelessWidget {
  final int index;
  final String name;
  final int price;
  final int number;
  final void Function() decrement;
  final void Function() increment;

  const FoodOfRestaurant({
    super.key,
    required this.name,
    required this.index,
    required this.price,
    required this.number,
    required this.decrement,
    required this.increment
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: GetSize.getWidth(context) * 0.3,
              child: Image.asset("assets/images/foods/food02.png"),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: GetSize.getWidth(context) * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$index. $name",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Cost: $price VNĐ",
                    style: const TextStyle(
                      color: ColorLib.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("$number")
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  color: ColorLib.primaryColor,
                  onPressed: increment,
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
                IconButton(
                    color: ColorLib.primaryColor,
                    onPressed: () {
                      decrement();
                    },
                    icon: const Icon(
                      Icons.remove,
                    ))
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: GetSize.getWidth(context),
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class CardSkeltonOrderRestaurant extends StatelessWidget {
  const CardSkeltonOrderRestaurant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skeleton(height: 80, width: GetSize.getWidth(context) * 0.3),
        const SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(height: 20, width: GetSize.getWidth(context) * 0.4),
            const SizedBox(
              height: 10,
            ),
            Skeleton(height: 20, width: GetSize.getWidth(context) * 0.15),
            const SizedBox(
              height: 10,
            ),
            Skeleton(height: 20, width: GetSize.getWidth(context) * 0.2),
          ],
        ),
      ],
    );
  }
}
