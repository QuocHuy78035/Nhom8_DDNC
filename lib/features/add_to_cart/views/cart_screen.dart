import 'package:ddnangcao_project/features/add_to_cart/controllers/add_to_cart_controller.dart';
import 'package:ddnangcao_project/features/order/controllers/order_controller.dart';
import 'package:ddnangcao_project/models/order.dart';
import 'package:ddnangcao_project/providers/add_to_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../main/views/store_category_screen.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int totalPrice = 0;
  late List<String> foodId = [];
  late List<int> quantity = [];
  final OrderController orderController = OrderController();
  final AddToCartController addToCartController = AddToCartController();

  @override
  void initState() {
    super.initState();
    Provider.of<AddToCartProvider>(context, listen: false).getAllCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Consumer<AddToCartProvider>(
                builder: (context, value, child) {
                  if (value.listCart.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (value.isLoading) {
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.listCart.length,
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
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.listCart.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: FoodOfRestaurant(
                                  increment: () {
                                    Provider.of<AddToCartProvider>(context,
                                            listen: false)
                                        .increment(index, context);
                                  },
                                  decrement: () {
                                    Provider.of<AddToCartProvider>(context,
                                            listen: false)
                                        .decrementCart(index, context);
                                  },
                                  name: value.listCart[index].food?.name ?? "",
                                  index: index + 1,
                                  price: NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                      .format(value.listCart[index].food?.price),
                                  number: value.listCart[index].number,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
              ElevatedButton(onPressed: ()async {
                OrderModel orderModel = OrderModel();
                for (int i = 0; i <   Provider.of<AddToCartProvider>(context, listen: false)
                    .listCart.length; i++) {
                  foodId.add(Provider.of<AddToCartProvider>(context, listen: false).listCart[i].food?.id ?? "");
                  quantity.add(Provider.of<AddToCartProvider>(context, listen: false).listCart[i].number ?? 0);
                  int? price = Provider.of<AddToCartProvider>(context, listen: false).listCart[i].food?.price;
                  int? number = Provider.of<AddToCartProvider>(context, listen: false).listCart[i].number;
                  totalPrice = price! * number!;
                }
                orderModel = await orderController.createOrder(
                  totalPrice,
                  180,
                  20,
                  "Ho chi minh",
                  "COD",
                  foodId,
                  quantity,
                );
                print("Status123 ${orderModel.status}");
              }, child: const Text("Press")),
              TextButton(
                  onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => UsePaypal(
                                sandboxMode: true,
                                clientId:
                                    "AfcHO079_yirebcCRj6BlKUhY48w9uq3k4k-EM6HCQTAKHt3Tp6Buzfn0f3b0PRqUKUQwWfLDQtKlJxz",
                                secretKey:
                                    "EBN8StcvtdYCRgC2wG1UlvPNHeitK9ehvABHievjJnLAjiB_P8lzkHsHH5OENl16yqIw5zexz7tLeiDu",
                                returnURL: "https://samplesite.com/return",
                                cancelURL: "https://samplesite.com/cancel",
                                transactions: const [
                                  {
                                    "amount": {
                                      "total": '70',
                                      "currency": "USD",
                                      "details": {
                                        "subtotal": '70',
                                        "shipping": '0',
                                        "shipping_discount": 0
                                      }
                                    },
                                    "description":
                                        "The payment transaction description.",
                                    "item_list": {
                                      "items": [
                                        {
                                          "name": "Apple",
                                          "quantity": 4,
                                          "price": '5',
                                          "currency": "USD"
                                        },
                                        {
                                          "name": "Pineapple",
                                          "quantity": 5,
                                          "price": '10',
                                          "currency": "USD"
                                        }
                                      ],
                                      // shipping address is Optional
                                      "shipping_address": {
                                        "recipient_name": "Raman Singh",
                                        "line1": "Delhi",
                                        "line2": "",
                                        "city": "Delhi",
                                        "country_code": "IN",
                                        "postal_code": "11001",
                                        "phone": "+00000000",
                                        "state": "Texas"
                                      },
                                    }
                                  }
                                ],
                                note:
                                    "Contact us for any questions on your order.",
                                onSuccess: (Map params) async {
                                  print("Success");
                                  print("onSuccess: $params");
                                },
                                onError: (error) {
                                  print("onError: $error");
                                },
                                onCancel: (params) {
                                  print('cancelled: $params');
                                }),
                          ),
                        )
                      },
                  child: const Text("Make Payment"),
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
  final String price;
  final int? number;
  final void Function() decrement;
  final void Function() increment;

  const FoodOfRestaurant(
      {super.key,
      required this.name,
      required this.index,
      required this.price,
      this.number,
      required this.decrement,
      required this.increment});

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
                    "Cost: $price",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Quantity: $number")
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
