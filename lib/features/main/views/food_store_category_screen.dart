import 'package:ddnangcao_project/features/main/controllers/main_controller.dart';
import 'package:ddnangcao_project/features/main/views/detail_food_screen.dart';
import 'package:ddnangcao_project/features/main/views/store_category_screen.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';

class FoodStoreCategoryScreen extends StatefulWidget {
  final String? cateName;
  final String? storeId;
  final String? cateId;

  const FoodStoreCategoryScreen(
      {super.key, required this.storeId, required this.cateId, required this.cateName});

  @override
  State<FoodStoreCategoryScreen> createState() =>
      _FoodStoreCategoryScreenState();
}

class _FoodStoreCategoryScreenState extends State<FoodStoreCategoryScreen> {
  final MainController mainController = MainController();
  List<FoodModel> listFood = [];

  getFoodByStoreIdAndCateId() async {
    listFood = await mainController.findAllFoodByStoreIdAndCateId(
        "${widget.storeId}", "${widget.cateId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.cateName}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getFoodByStoreIdAndCateId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.builder(
                      itemCount: listFood.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         DetailFoodScreen(
                                  //       foodId: listFood[index].id ?? "",
                                  //       foodName: "${listFood[index].name}",
                                  //       price: listFood[index].price ?? 0,
                                  //       image: '',
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailFoodScreen(
                                            foodName:
                                                listFood[index].name ?? "",
                                            price: listFood[index].price ?? 0,
                                            image: listFood[index].image,
                                            foodId: listFood[index].id ?? ""),
                                      ),
                                    );
                                  },
                                  child: Food(
                                    left: listFood[index].left,
                                    sold: listFood[index].sold,
                                    name: listFood[index].name ?? "",
                                    price: listFood[index].price,
                                    rating: listFood[index].rating,
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.separated(
                      itemCount: listFood.length,
                      itemBuilder: (context, index) => const NewsCardSkelton(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Food extends StatelessWidget {
  final String name;
  final int? rating;
  final int? price;
  final int? left;
  final int? sold;
  final String? image;

  const Food(
      {super.key,
      required this.name,
      this.rating,
      required this.price,
      this.image,
      this.left,
      this.sold});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image ?? "assets/images/foods/food_search.png",
          width: 88,
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: GetSize.getWidth(context) * 0.62,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              Text(
                "Price: $price VNĐ",
                maxLines: 1,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorLib.blackColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 20,
                        color: ColorLib.primaryColor,
                      ),
                      Text(
                        "$left",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: ColorLib.primaryColor,
                        size: 20,
                      ),
                      Text(
                        "$sold",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: ColorLib.primaryColor,
                        size: 20,
                      ),
                      Text(
                        "$rating",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
