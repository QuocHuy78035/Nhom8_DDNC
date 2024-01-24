import 'package:ddnangcao_project/features/main/views/detail_food.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import '../../../utils/color_lib.dart';

class RestaurantOrder extends StatefulWidget {
  const RestaurantOrder({super.key});

  @override
  State<RestaurantOrder> createState() => _RestaurantOrderState();
}

class _RestaurantOrderState extends State<RestaurantOrder> {
  final ScrollController scrollController = ScrollController();

  bool showHeader = false;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 48) {
        if (showHeader) return;
        setState(() {
          showHeader = true;
        });
      } else {
        if (!showHeader) return;
        setState(() {
          showHeader = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/images/foods/food01.png",
                            width: GetSize.getWidth(context),
                          ),
                          Positioned(
                            top: 30,
                            left: 0,
                            child: IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back,
                            color: ColorLib.blackColor,
                            size: 30,)
                          ),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GetSize.symmetricPadding * 2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Nha Hang",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 34),
                            ),
                            SizedBox(
                              width: GetSize.getWidth(context) * 0.8,
                              child: const Text(
                                "Description",
                                style: TextStyle(fontSize: 22),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/foods/star-Filled.png",
                                  height: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Excellent 9.5"),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/foods/truck-fast.png",
                                      height: 14,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Delivery in 40-50 min"),
                                        Text(
                                          "Home (HCM)",
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        color: ColorLib.secondaryColor),
                                    child: const Center(
                                      child: Text(
                                        "Change",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: ColorLib.primaryColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/foods/timer.png",
                                  height: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("10:00 - 22:00"),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Popular items",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FoodOfRestaurant(),
                            FoodOfRestaurant(),
                            FoodOfRestaurant(),
                            FoodOfRestaurant()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if (showHeader)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  backgroundColor: Colors.white,
                  leading: BackButton(),
                  title: Text(
                    "NHA HANG",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class FoodOfRestaurant extends StatelessWidget {
  const FoodOfRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: GetSize.getWidth(context) * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. Pesto pasta",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Desription 12312312312312312312312123123123",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text("150.000 VND",
                      style: TextStyle(
                        color: ColorLib.primaryColor,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
            SizedBox(
              width: GetSize.getWidth(context) * 0.3,
              child: Image.asset("assets/images/foods/food02.png"),
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
