import 'package:ddnangcao_project/features/food/views/detail_food_screen.dart';
import 'package:ddnangcao_project/features/main/views/store_category_screen.dart';
import 'package:ddnangcao_project/providers/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';

class FoodStoreCategoryScreen extends StatefulWidget {
  final String? cateName;
  final String? storeId;
  final String storeName;
  final String? cateId;

  const FoodStoreCategoryScreen(
      {super.key, required this.storeId, required this.cateId, required this.cateName, required this.storeName});

  @override
  State<FoodStoreCategoryScreen> createState() =>
      _FoodStoreCategoryScreenState();
}

class _FoodStoreCategoryScreenState extends State<FoodStoreCategoryScreen> {

  @override
  void initState(){
    super.initState();
    Provider.of<FoodProvider>(context, listen: false).getFoodByStoreIdAndCateId(widget.storeId ?? "", widget.cateId ?? "");
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
            Consumer<FoodProvider>(builder: (context, value, child){
              if(value.listFood.isEmpty){
                return const Center(
                  child:Center(
                    child: Text("No Have Item"),
                  ),
                );
              }else{
                if(value.isLoading){
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.separated(
                      itemCount: value.listFood.length,
                      itemBuilder: (context, index) => const NewsCardSkelton(),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                    ),
                  );
                }else{
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.builder(
                      itemCount: value.listFood.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailFoodScreen(
                                      sold: value.listFood[index].sold,
                                      left: value.listFood[index].left,
                                      storeName: widget.storeName,
                                        foodName:
                                        value.listFood[index].name ?? "",
                                        price: value.listFood[index].price ?? 0,
                                        image: value.listFood[index].image,
                                        foodId: value.listFood[index].id ?? ""),
                                  ),
                                );
                              },
                              child: Food(
                                left: value.listFood[index].left,
                                sold: value.listFood[index].sold,
                                name: value.listFood[index].name ?? "",
                                price: value.listFood[index].price,
                                rating: value.listFood[index].rating,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
              }
            })
          ],
        ),
      ),
    );
  }
}

class Food extends StatelessWidget {
  final String name;
  final String? rating;
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
