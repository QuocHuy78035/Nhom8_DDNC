import 'package:ddnangcao_project/features/main/views/detail_food_screen.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import '../../../utils/color_lib.dart';
import '../../restaurant/controllers/restaurant_controler.dart';
import 'store_category_screen.dart';

class RestaurantOrderScreen extends StatefulWidget {
  final String name;
  final String address;
  final double rating;
  final String timeOpen;
  final String timeClose;
  final String storeId;

  const RestaurantOrderScreen(
      {super.key,
      required this.name,
      required this.address,
      required this.rating,
      required this.timeOpen,
      required this.timeClose,
      required this.storeId});

  @override
  State<RestaurantOrderScreen> createState() => _RestaurantOrderScreenState();
}

class _RestaurantOrderScreenState extends State<RestaurantOrderScreen> {
  final ScrollController scrollController = ScrollController();
  final RestaurantController restaurantController = RestaurantController();
  bool showHeader = false;
  List<FoodModel> listFood = [];

  getFoodByResId() async {
    listFood = await restaurantController.findAllFoodByStoreId(widget.storeId);
  }

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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: ColorLib.blackColor,
                                  size: 30,
                                )),
                          )
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
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 34),
                            ),
                            SizedBox(
                              width: GetSize.getWidth(context) * 0.8,
                              child: Text(
                                widget.address,
                                style: const TextStyle(fontSize: 22),
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
                                Text("Excellent with ${widget.rating} star"),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        borderRadius: BorderRadius.circular(20),
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
                                Text(
                                    "${widget.timeOpen} - ${widget.timeClose}"),
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
                            FutureBuilder(
                              future: getFoodByResId(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listFood.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailFoodScreen(
                                                    foodId:
                                                        listFood[index].id ??
                                                            "",
                                                    foodName:
                                                        listFood[index].name ??
                                                            "",
                                                    price:
                                                        listFood[index].price ??
                                                            0,
                                                    image:
                                                        listFood[index].image ??
                                                            "",
                                                  ),
                                                ),
                                              );
                                            },
                                            child: FoodOfRestaurant(
                                              name: listFood[index].name ?? "",
                                              index: index + 1,
                                              price: listFood[index].price ?? 0,
                                              type: listFood[index]
                                                      .category
                                                      ?.cateName ??
                                                  "",
                                              rating:
                                                  listFood[index].price ?? 0,
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: listFood.length,
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
                  leading: const BackButton(),
                  title: Text(
                    widget.name,
                    style: const TextStyle(color: Colors.black),
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
  final int index;
  final String name;
  final int price;
  final int rating;
  final String type;

  const FoodOfRestaurant(
      {super.key,
      required this.name,
      required this.index,
      required this.price,
      required this.type,
      required this.rating});

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
                  Text(
                    "Type: $type",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
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
                  )
                ],
              ),
            ),
            IconButton(
                color: ColorLib.primaryColor,
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                ))
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
