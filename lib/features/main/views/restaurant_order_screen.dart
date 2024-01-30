import 'package:ddnangcao_project/features/main/views/detail_food_screen.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import '../../../providers/restaurant_provider.dart';
import '../../../utils/color_lib.dart';
import 'store_category_screen.dart';
import 'package:provider/provider.dart';


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
  bool showHeader = false;
  int count = 0;

  List<int> costFood = [];

  @override
  void initState() {
    Provider.of<RestaurantProvider>(context, listen: false).getFoodByResId(widget.storeId);
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
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                                SizedBox(
                                  width: GetSize.getWidth(context) * 0.8,
                                  child: Text(
                                    widget.address,
                                    style: const TextStyle(fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/foods/star-Filled.png",
                                      height: 14,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("${widget.rating} (999+ Reviewed)"),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text('17 min')
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.favorite_outline,
                                  color: ColorLib.primaryColor,
                                )
                              ],
                            ),
                          ),
                          const Distance(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/foods/truck-fast.png",
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Standard Delivery",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "Home (HCM)",
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: const Center(
                                            child: Text(
                                              "Change",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorLib.primaryColor),
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
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Distance(),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Popular items",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26),
                                    ),
                                    Consumer<RestaurantProvider>(builder: (context, value, child){
                                      if(value.listFood.isEmpty){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }else{
                                        if(value.isLoading){
                                          return Column(
                                            children: [
                                              ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemCount: value.listFood.length,
                                                itemBuilder: (context, index) =>
                                                const CardSkeltonOrderRestaurant(),
                                                separatorBuilder: (context,
                                                    index) =>
                                                const SizedBox(height: 16),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          );
                                        }else{
                                          return ListView.builder(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: value.listFood.length,
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
                                                                sold:
                                                                value.listFood[index]
                                                                    .sold,
                                                                left:
                                                                value.listFood[index]
                                                                    .left,
                                                                foodId:
                                                                value.listFood[index]
                                                                    .id ??
                                                                    "",
                                                                foodName:
                                                                value.listFood[index]
                                                                    .name ??
                                                                    "",
                                                                price: value.listFood[
                                                                index]
                                                                    .price ??
                                                                    0,
                                                                image: value.listFood[
                                                                index]
                                                                    .image ??
                                                                    "",
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    child: FoodOfRestaurant(
                                                      onPressed: () {
                                                        setState(() {
                                                          count += 1;
                                                        });
                                                      },
                                                      sold:
                                                      value.listFood[index].sold,
                                                      left:
                                                      value.listFood[index].left,
                                                      name: value.listFood[index]
                                                          .name ??
                                                          "",
                                                      index: index + 1,
                                                      price: value.listFood[index]
                                                          .price ??
                                                          0,
                                                      type: value.listFood[index]
                                                          .category
                                                          ?.cateName ??
                                                          "",
                                                      rating: value.listFood[index]
                                                          .price ??
                                                          0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      }
                                    })
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
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
      bottomSheet: count != 0
          ? BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            size: 60,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorLib.primaryColor),
                              child: Text(
                                "$count",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "Total: VND",
                        style: TextStyle(
                            fontSize: 18, color: ColorLib.primaryColor),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorLib.primaryColor),
                          onPressed: () {},
                          child: const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : null,
    );
  }
}

class Distance extends StatelessWidget {
  const Distance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 4,
          width: GetSize.getWidth(context),
          color: Colors.black12,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class FoodOfRestaurant extends StatelessWidget {
  final int index;
  final void Function()? onPressed;
  final String name;
  final int price;
  final int rating;
  final String type;
  final int? left;
  final int? sold;

  const FoodOfRestaurant(
      {super.key,
      required this.name,
      required this.index,
      required this.price,
      required this.type,
      this.onPressed,
      this.sold,
      this.left,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$index. $name",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Type: $type",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        '$sold sold',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 14,
                        width: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '$left left',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        "$price VNĐ",
                        style: const TextStyle(
                            color: ColorLib.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        color: ColorLib.primaryColor,
                        child: Center(
                          child: IconButton(
                            color: Colors.white,
                            onPressed: onPressed,
                            icon: const Icon(
                              size: 16,
                              Icons.add,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: GetSize.getWidth(context),
          height: 1,
          color: Colors.black12,
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
